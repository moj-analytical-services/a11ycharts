#' @importFrom magrittr `%>%`

# Internal functions for setting different parameters depending on chart type

# Sets line and bar thickness and colour

chart_type <- function(type,groupvar){

  if (type =="line") {
    if (is.null(groupvar)){
      ggplot2::geom_line(size = 1.5, colour="#12436D")
    } else {
      ggplot2::geom_line(size = 1.5)
    }
  } else if (type %in% c("bar","horizontalBar")) {
    ggplot2::geom_bar(stat="identity", fill="#12436D")
  }

}

# Sets x axis labels

x_scale <- function(type,df,xvar) {

  if (type %in% c("line","bar","horizontalBar")){
    ggplot2::scale_x_continuous(breaks=1:nrow(df),
                       label=df[[xvar]])
  } else {
    ggplot2::scale_x_discrete(limits = levels(factor(df[[xvar]])))
  }

}
