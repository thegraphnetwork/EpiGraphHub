# Airflow Overview

## Webserver

![Webserver](https://i.imgur.com/OnR2c0X.png)

The Airflow Webserver is the GUI of Airflow. The Webserver's first page is the login page, the Users are defined in `airflow.cfg` and created during the Docker build of EpiGraphHub, more information about user configuration can be found in [Airflow's Official Documentation](https://airflow.apache.org/docs/apache-airflow/stable/security/webserver.html). The Webserver, although it's not necessary to the Airflow's operation, will work as an endpoint for the user, there you can: 
- easily find important information about the DAG and tasks runs;
- manually trigger DAGs, pause or delete them;
- follow the logs of a task run individually;
- configure PostgreSQL, AWS, MongoDB, Google Cloud (and much, much more) external connections;

As the [Airflow Scheduler](#Scheduler) constantly compiles DAGs into the internal Airflow's database, broken DAGs, missing scheduler and other critical errors will appear in the GUI landing page:
![Import Error Example](https://i.imgur.com/MkMZCI7.png)

### DAG run

A DAG will be triggered as defined in it's code, when creating a DAG, an interval between the runs is defined in the `schedule_interval` variable. Some accepted intervals are `@once`, `@daily`, `@weekly`. Also as CRON patterns:  `0  0  1  *  *` (monthly at midnight of day 1), `30 18 * 6-12 MON-FRI` (at  18:30  on every day-of-week from Monday through Friday  in every month from June through December). Check the [Official Documentation](https://airflow.apache.org/docs/apache-airflow/stable/dag-run.html) for more schedule intervals details. A DAG also can be manually triggered in the GUI or via [Command Line](https://airflow.apache.org/docs/apache-airflow/stable/cli-and-env-variables-ref.html), in the Graph tab of the Webserver it is possible to see the run in realtime when the DAG is triggered: 

![Manual trigger via GUI](https://i.imgur.com/wq1P3dv.png)

### Task log

Each task produces its own log every run, the log of a task can be accessed by clicking a task in the graph:

![check_last_update task](https://i.imgur.com/YPHSU4p.png)

In the logs we will be able to see each step Airflow ran to execute the task, the command line used to run, errors if occurred, dependencies with other tasks, and other details, such as variables consumed and returned by the Operators. As the `logging` module is configured in Colombia DAG (`check_last_update` task) to inform the last update date of the EpiGraphHub data, the stdout can be found in Log section:

![Last Colombia Update Log](https://i.imgur.com/4blY1I6.png)

### Rendered Template & XComs

XCom and Rendered Template define the behavior of a task, it's how Airflow controls the relation between tasks and define which information was received from previous tasks and which will be shared forward to the next ones. Let's take, for instance, the `foph` DAG, that receives different CSV files and generates a Task Instance for each file, looping through a relation of tables (list of dicts). The [Scheduler](#Scheduler) will compile the DAG and fill the information generated with the variables received from previous tasks, we can see the dictionary received from the list iteration in the Rendered Template section:

![foph task template](https://i.imgur.com/ao7dJcE.png)

XComs (short for “cross-communications”) are stored by default in the Task Instance and can be turned off setting the `do_xcom_push` to `False`. A task's XCom can be stored as a variable during the task run as well:
```python
value = task_instance.xcom_pull(task_ids='some_task')
```
Note that XComs are meant for small data sharing between tasks, it may not (and shouldn't) work for larger data as DataFrames nor SQL Query results, please check the [XComs Official Documentation](https://airflow.apache.org/docs/apache-airflow/stable/concepts/xcoms.html) for more details. 

In `foph` DAG one of the XComs is the relation between the `compare` task with the next one, and its returned value, which in this case will be an [Empty Task](#Empty-Task), followed by a task that updates the table in psql database:

![table needs update](https://i.imgur.com/ck8W9TZ.png)

## DAGs

### Triggering a DAG

You can relate a DAG being the blueprint of a workflow. They can contain complex logic operations that do all sort of operations, or they can be triggered to do a specific job. As mentioned before, a DAG usually is triggered within a schedule interval, but it also can be triggered via a [TriggerDagRunOperator](https://github.com/apache/airflow/blob/main/airflow/example_dags/example_trigger_controller_dag.py) or manually via GUI or CLI. To trigger a DAG in CLI, you can type:

```python
airflow dags trigger <dag_id>
```

### Default Args


Each DAG will have its specification, the `default_args` will define the configuration of the DAG and every task will inherit the same logic, which can be overridden. One example of it can be the `retries` argument, if defined only in the DAG, every task will retry the same number of times, but can be override using the `retries` argument in the task. Some `default_args` are:
| Argument | Definition  | Example |
|:----:|:-----:|:-----:|
|`owner`| Only the specified user or Admin will see the DAG | `str`
|`depends_on_past`| If True, the DAG or task will only run if the previous task in the previous _DAG run_ was successful| `bool` | 
|`schedule_interval`| Defines the interval of each DAG run | `@once`, `@daily`, <br>`14 30 1 * *`|
|`start_date`| Can be a future or the past date, may be used for catching up old data as well | `datetime` or `pendulum` objects |
|`retries`| How many times each task will retry if failed | `int` |
|`retry_delay`| The delay before retrying | `timedelta(minutes=1)` |
|`catchup`| Uses the schedule interval and the start date to back fill data | `bool` |
|`default_args`| A dict of default arguments can be specified to keep the code clean | `dict` |
|`email`, `email_on_failure`, `email_on_retry` | Auto email if something went wrong | `list`; `bool`; `bool`|

Check out the [Official Documentation](https://airflow.apache.org/docs/apache-airflow/stable/tutorial.html#default-arguments) to see the entire list of default arguments.

### Catchup

The catchup argument can be a bit tricky to understand. Imagine you have a DAG responsible for retrieve the log of an operation and save to a SQL database that runs every 24 hours. It will use the DAG run date as the parameter for fetching what data it will load (for example the failed logs between today at 11pm and yesterday at 11pm). If  the argument `catchup` is set to `True`, the DAG will take (in this case a task for every day) back to the `start_date`, generating automatically the tasks and filling the failed logs that match each day in the past.  

### Trigger Rules

By default, Airflow will wait for all upstream (direct parents) tasks for a task to be  [successful](https://airflow.apache.org/docs/apache-airflow/stable/concepts/tasks.html#concepts-task-states)  before it runs that task. However, this is just the default behavior, and you can control it using the  `trigger_rule`  argument to a Task. The options for  `trigger_rule`  are:

| `trigger_rule` | Definition |
|:----:|:----:|
|`all_success` | Default, all upstream tasks have succeeded
| `all_failed` | All upstream tasks are in a `failed` or `upstream_failed` state
| `all_done` | All upstream tasks are done with their execution
| `all_skipped` | All upstream tasks are in a `skipped` state
| `one_failed` | At least one upstream task has failed (does not wait for all upstream tasks to be done)
| `one_success` | At least one upstream task has succeeded (does not wait for all upstream tasks to be done)
| `none_failed` | All upstream tasks have not `failed` or `upstream_failed` - that is, all upstream tasks have succeeded or been skipped
| `none_failed_min_one_success` | All upstream tasks have not `failed` or `upstream_failed`, and at least one upstream task has succeeded.
| `none_skipped` | No upstream task is in a `skipped` state - that is, all upstream tasks are in a `success`, `failed`, or `upstream_failed` state.
| `always` | No dependencies at all, run this task at any time

## Tasks
### Operators
Task Operators differ in its integration. Although Airflow is restricted to use with Python, it also integrates different backends, there are 50 different Operators that are responsible to operate over certain environment, some examples are BashOperators that run Shell Script code, SQLOperators, EmailOperators, S3Operators, and so on. You can see all Operators in [Official Documentation](https://airflow.apache.org/docs/apache-airflow/stable/_api/airflow/operators/index.html).



## Scheduler
