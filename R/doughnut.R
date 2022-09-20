#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes_string
#' @importFrom ggplot2 geom_rect
#' @importFrom ggplot2 coord_polar
#' @importFrom ggplot2 xlim
#' @importFrom ggplot2 theme_void
#' @importFrom ggplot2 scale_fill_manual
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_blank

# Function for creating a doughnut chart

doughnut <- function(df, xvar, yvar) {

  ddf <- df

  ddf[[xvar]] <- factor(ddf[[xvar]], levels=ddf[[xvar]])

  # Compute percentages
  ddf$fraction <- ddf[[yvar]] / sum(ddf[[yvar]])

  # Compute the cumulative percentages (top of each rectangle)
  ddf$ymax <- cumsum(ddf$fraction)

  # Compute the bottom of each rectangle
  ddf$ymin <- c(0, head(ddf$ymax, n=-1))

  # Make the plot
  plot <- ggplot(ddf, aes_string(ymax="ymax", ymin="ymin", xmax=4, xmin=3, fill=xvar)) +
    geom_rect() +
    coord_polar(theta="y") +
    xlim(c(2, 4)) +
    theme_void() +
    scale_fill_manual(values=c("#12436D","#28A197","#801650","#F46A25")) +
    theme(legend.title=element_blank())

  return(plot)
}
