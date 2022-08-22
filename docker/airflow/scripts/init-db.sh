#!/usr/bin/env bash
# source: https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml

function ver() {
  printf "%04d%04d%04d%04d" ${1//./ }
}
airflow_version=$(AIRFLOW__LOGGING__LOGGING_LEVEL=INFO && airflow version)
airflow_version_comparable=$(ver ${airflow_version})
min_airflow_version=2.2.0
min_airflow_version_comparable=$(ver ${min_airflow_version})
if (( airflow_version_comparable < min_airflow_version_comparable )); then
  echo
  echo -e "\033[1;31mERROR!!!: Too old Airflow version ${airflow_version}!\e[0m"
  echo "The minimum Airflow version supported: ${min_airflow_version}. Only use this or higher!"
  echo
  exit 1
fi
if [[ -z "${AIRFLOW_UID}" ]]; then
  echo
  echo -e "\033[1;33mWARNING!!!: AIRFLOW_UID not set!\e[0m"
  echo "If you are on Linux, you SHOULD follow the instructions below to set "
  echo "AIRFLOW_UID environment variable, otherwise files will be owned by root."
  echo "For other operating systems you can get rid of the warning with manually created .env file:"
  echo "    See: https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html#setting-the-right-airflow-user"
  echo
fi
one_meg=1048576
mem_available=$(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE) / one_meg))
cpus_available=$(grep -cE 'cpu[0-9]+' /proc/stat)
disk_available=$(df / | tail -1 | awk '{print $4}')
warning_resources="false"
if (( mem_available < 4000 )) ; then
  echo
  echo -e "\033[1;33mWARNING!!!: Not enough memory available for Docker.\e[0m"
  echo "At least 4GB of memory required. You have $(numfmt --to iec $((mem_available * one_meg)))"
  echo
  warning_resources="true"
fi
if (( cpus_available < 2 )); then
  echo
  echo -e "\033[1;33mWARNING!!!: Not enough CPUS available for Docker.\e[0m"
  echo "At least 2 CPUs recommended. You have ${cpus_available}"
  echo
  warning_resources="true"
fi
if (( disk_available < one_meg * 10 )); then
  echo
  echo -e "\033[1;33mWARNING!!!: Not enough Disk space available for Docker.\e[0m"
  echo "At least 10 GBs recommended. You have $(numfmt --to iec $((disk_available * 1024 )))"
  echo
  warning_resources="true"
fi
if [[ ${warning_resources} == "true" ]]; then
  echo
  echo -e "\033[1;33mWARNING!!!: You have not enough resources to run Airflow (see above)!\e[0m"
  echo "Please follow the instructions to increase amount of resources available:"
  echo "   https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html#before-you-begin"
  echo
fi
mkdir -p /sources/logs /sources/dags /sources/plugins

airflow db init
