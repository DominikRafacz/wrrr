#' Withr-like function for temporarily applying ggplot theme
#' 
#' @importFrom withr with_
#' @importFrom ggplot2 theme_set
with_ggtheme <- withr::with_(theme_set)
