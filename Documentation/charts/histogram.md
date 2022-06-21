
## Histogram 

The histogram can be used to provide the distribution of our data. Using the `positive_cases_covid_d` dataset, let’s plot a histogram of the age of dead individuals. 

In this case, we will use the columns:

1. `edad` that refers to the age of the individual, 
2. `unidad_medida` to ensure that the value in `edad` represents years, and
3. `estado` to filter by the `Fallecido` (dead individuals).

To do this, open the `positive_cases_covid_d` dataset and click on the `Table` value to change the VISUALISATION TYPE:

<center>

![](images/change_viz_type.png){width=300px}

</center>

In the window that will open, type `histogram`:

<center>

![](images/type_histogram.png){width=750px}

</center>

Click on the histogram and on the `SELECT` button. 

In the Explore Page, select the column `edad` in the COLUMNS field and apply the two filters presented below:

<center>
![](images/hist_filter_1.png){width=300px}![](images/hist_filter_2.png){width=300px}
</center>

So, your final query configuration is: 

<center>

![](images/hist_final_query.png){width=300px}

</center>

After clicking on the `RUN QUERY` button, this will be the displayed result: 

<center>

![](images/plot_hist_1.png){width=500px}

</center>

To change the number of bins in the histogram, go to the CUSTOMIZE tab: 

<center>

![](images/hist_customize.png){width=500px}

</center>

and change the NO OF BINS field:

<center>

![](images/hist_no_bins.png){width=300px}

</center>

After setting `NO OF BINS` to 20, you will get the result below:

<center>

![](images/hist_no_bins_20.png){width=500px}

</center>

If you hover the mouse over the bars, you get the information about what range of the `edad` (age) the bar represents, what is the exact count, cumulative, and percentile that this bar represents:

<center>

![](images/info_hist.png){width=500px}

</center>

It is now time to :

1.  Specify a title for the chart, for instance `Age of dead individuals by COVID-19 in Colombia`,
2.  Save it, by clicking on `+SAVE` button in the middle panel.
