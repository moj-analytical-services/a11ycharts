#' Build a simple mojchart
#'
#' This function produces an accessible chart based on a data frame.
#'
#' @param df data frame containing data
#' @param xvar variable from data frame which contains x-axis labels
#' @param yvar variable from data frame which contains y-axis labels
#' @param chart_type chart type to generate. Accepted values are "line", "bar", "horizontalBar" and "doughnut"
#' @param groupvar variable from data frame which contains a grouping variable
#' @param yscale numerical format for y-axis values. Accepted values are "int", "percent" and "float"
#' @return A ggplot2 object
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes_string
#' @importFrom ggplot2 scale_y_continuous
#' @importFrom ggplot2 expansion
#' @importFrom ggplot2 expand_limits
#' @importFrom ggplot2 scale_colour_manual
#' @importFrom ggplot2 coord_flip
#' @export
mojchart_simple <- function(df,xvar,yvar,chart_type,groupvar=NULL,yscale="int") {

  if (chart_type == "doughnut") {
    plot <- doughnut(df,xvar,yvar)
  } else if (chart_type %in% c("line","bar","horizontalBar")) {

    plotdf <- format_df(df,xvar,chart_type,groupvar)

    plot <-  ggplot(plotdf, aes_string(x = "rownum", y = yvar, colour=groupvar)) +
      scale_y_continuous(label={ if (yscale=="percent") scales::percent_format(accuracy = 1L) else if (yscale %in% c("int","float")) scales::comma},
                         expand = expansion(mult = c(0, 0.05))) +
      expand_limits(y = 0) +
      mojchart::theme_gss(xticks = TRUE, flipped = (chart_type == "horizontalBar")) +
      chart_type(chart_type,groupvar) +
      x_scale(chart_type,plotdf,xvar) +
      scale_color_manual(values=c("#12436D","#28A197","#801650","#F46A25")) +
      { if (chart_type == "horizontalBar") coord_flip() }

  }

  return(plot)

}
