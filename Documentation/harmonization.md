# Data Transformation and Harmonization

You can use our platform's `SQL editor` section to clean data or make changes in the datasets using SQL queries. 

**For security, external users can only query the `sandbox` or `google sheets` database.**


For example, you can replace the values in a column of the dataset using the code below: 

```
UPDATE 
    table_name
SET
    column_name = REPLACE(column_name, old_value,new_value)
WHERE
    column_name = old_value;
```