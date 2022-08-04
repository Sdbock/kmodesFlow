


#' @title plot_elbow
#'
#' @param models tibble created from `fit_models()`
#' @description Creates an "elbow plot" of fit statistics for kmodes models.
#' @return ggplot object
#' @export
#'
#' @examples models <- fit_models(data)
#'           plot_elbow(models)
#'
#'
plot_elbow <-
  function(models){
    models %>%
      ggplot2::ggplot(ggplot2::aes(x = k, y = as.numeric(gof))) +
      ggplot2::geom_point() +
      ggplot2::geom_line() +
      ggplot2::scale_x_continuous(breaks = c(1:length(models$k))) +
      ggthemes::theme_clean() +
      ggplot2::labs(
        x = "# of clusters",
        y = "Sum of within-cluster differences",
        title = "Goodness of fit across different cluster solutions"
      ) +
      ggplot2::theme(plot.background = ggplot2::element_rect(color = "white"))
  }
