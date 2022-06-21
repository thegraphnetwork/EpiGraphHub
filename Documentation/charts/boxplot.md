
## Boxplot

The boxplots can be used to summarise the statistics of the values in a column. Using the `positive_cases_covid_d` dataset, let’s plot a histogram of the age of dead individuals. 

In this case, we will use the columns:

1. `edad` that refers to the age of the individual, 
2. `unidad_medida` to ensure that the value in `edad` represents years, and
3. `estado` to filter by the `Fallecido` (dead individuals).

To do this, open the `positive_cases_covid_d` dataset and click on the `Table` value to change the VISUALISATION TYPE:

<center>

![](images/change_viz_type.png){width=300px}

</center>

In the window that will open, type `box plot`:


<center>

![](images/type_boxplot.png){width=750px}

</center>

Click on the Box Plot and on the `SELECT` button.

For this chart, the METRICS field is mandatory. As we are interested in the age distribution, let’s start by setting the METRICS field to `AVG(edad)` in the Query section.

<center>

![](images/box_plot_metrics.png){width=300px}

</center>

And `RUN QUERY`. You should then get the following result, with only one box plot representing all age values in our dataset:

<center>

![](images/box_plot_example.png){width=500px}

</center>

::: key-point 
By default, the temporal column defined in TIME COLUMN and the TIME GRAIN are used to compute the value in METRICS. 
:::

In the result above, it means that :

1. all patients’ records were first grouped by `Day` based on the `fecha_reporte_web`column, then
2. the average ages (METRICS = `AVG(edad)`) by day were computed, and eventually 
3. the distribution of these average ages was plotted 

::: practice
To convince yourself about the explanation above, change the operator in the METRICS field from AVG to SUM, and see how it impacts the plotted distribution.
:::

Now, to see the distribution of the age of individuals, without prior aggregation by time,  we will fill the field DISTRIBUTE ACROSS with the `id_de_caso` column, representing the unique case ID of each record in our dataset . This will ensure that the box plot will use the age of each individual patient.

As a consequence of using DISTRIBUTE ACROSS = `id_de_caso`, selecting the AGGREGATE operator in METRICS to be SUM or AVG will not change the result distribution. Let's then keep METRICS as `AVG(edad)`. 

To get the age in years only for the dead individuals, let’s apply the two filters presented below:

<center>

![](images/hist_filter_1.png){width=300px}![](images/hist_filter_2.png){width=300px}

</center>

In the `SERIES` field, we will select the column with unique values to be shown along the X axis. For each unique value in this column, a box plot will be computed.

To get one box plot for each department in Colombia, let’s set SERIES to the column `departamento_nom`. So, your final query configuration is the following:

 

<center>

![](images/box_final_query.png){width=300px}

</center>

After clicking on the `RUN QUERY` button, this will be the received result:

<center>

![](images/box_plot_1.png){width=500px}

</center>


To see the name of the `departamento_nom` associated with each box plot, we can rotate the X axis labels. To do this, go to the CUSTOMISE tab:


<center>

![](images/box_customize.png){width=500px}

</center>

and change the X TICK LAYOUT field to `90º`:

<center>

![]images//box_x_tick.png){width=300px}

</center>

and that’s the result:

<center>

![](images/box_plot_2.png){width=500px}

</center>


If you hover the mouse over a box plot, you get the information about the quartiles, observation, and outliers:

<center>

![](images/box_plot_hover.png){width=500px}

</center>

It is now time to :

1.  Specify a title for the chart, for instance `Age of dead individuals by COVID-19 in Colombia`,
2.  Save it, by clicking on `+SAVE` button in the middle pane.

You can also change the time range considered in the region below:

<center>

![](images/box_time_filter.png){width=300px}

</center>

And in the field below, you can change the type of box plot: 

<center>

![](images/boxplot_options.png){width=300px}

</center>

By default, it uses `Tukey`, where the min and max values are at most 1.5 times the IQR (interquartile range) from the first quartile (25 percentile) and third quartile (75 percentile), respectively. The other available options are:

* `Min/max (no outliers)`;
* `2/98 percentiles`;
* `9/91 percentiles`.
