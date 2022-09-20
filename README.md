# a11ycharts
Package for creating accessible charts in R

## Installation
```
devtools::install_github("moj-analytical-services/a11ycharts")
```

## How to use

This package can convert data within an R data frame into a chart. At present the package can create four types of chart: line, bar, horizontal bar and doughnut.

The package contains one function: *a11ychart* which is defined as follows:
```
a11ychart(df,xvar,yvar,chart_type,groupvar=NULL,yscale="int")
```
To generate a chart, you will need to construct a dataframe in R which contains your data and x-axis labels. 
The data frame should be built in the order you want the data to appear in the chart, the package does not sort the data frame.
x-axis labels should be stored as strings. 


The arguments for this function are:

**df:** The data frame you wish to use to create the chart

**xvar:** The variable within the data frame that contains x-axis variable labels. In the case of a Horizontal bar chart, this will appear on the vertical axis

**yvar:** The variable within the data frame that contains values for each data point. In the case of a Horizontal bar chart, this will appear on the horizontal axis

**chart_type:** Accepted values are "line", "bar", "horizontalBar" or "doughnut"

**groupvar**: This is any grouping variable within your data. This option can only be used with a line chart

**yscale:** This gives the number format for use on the y scale. The options are "int", "float" or "percent"
