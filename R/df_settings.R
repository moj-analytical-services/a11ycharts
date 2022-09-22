#' @importFrom magrittr `%>%`

# Internal functions for setting up data frames depending on chart type

# Function to insert line breaks into x-axis labels

linebreaks <- function(df,xvar) {

  df[[xvar]] <- if (any(stringr::str_detect(df[[xvar]],"to"))) {
                  stringr::str_replace(df[[xvar]],"to ","to\n")
                } else if (any(stringr::str_detect(df[[xvar]],"quarterly average"))) {
                  stringr::str_replace(df[[xvar]]," quarterly average","\nquarterly average")
                } else {
                  stringi::stri_replace_last_fixed(df[[xvar]]," ","\n")
                }
  return(df)
}

# Function to remove labels at set intervals

labelbreaks <- function(df,xvar,breakwidth=NULL) {

  if (is.null(breakwidth)) {

    breakwidth <- if (length(df[[xvar]]) < 8) {-1}
                  else if (length(df[[xvar]]) < 15) {-2}
                  else if (length(df[[xvar]]) < 22) {-4}
                  else {-8}

  }

  df[[xvar]][-seq(length(df[[xvar]]),1,by=breakwidth)] <- ""

  return(df)

}

# Function to combine above functions and format data frame.

format_df <- function(df,xvar,chart_type,groupvar=NULL,breakwidth=NULL) {

# Add row number to data frame to order chart categories

  df <- df %>% { if (!is.null(groupvar)) dplyr::group_by(.,get(groupvar)) else . } %>% dplyr::mutate(rownum = dplyr::row_number())

  if (chart_type %in% c("line","bar")) {
    df <- linebreaks(df,xvar)

    if (is.null(groupvar)){
      df <- labelbreaks(df,xvar,breakwidth)
    } else {
      df <- df %>% dplyr::group_by(get(groupvar)) %>% dplyr::group_modify(~labelbreaks(.x,xvar))
    }
  }

  return(df)

}

