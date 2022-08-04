#' @title fit_models
#'
#' @returns Tibble with results for each model
#' @description Fit x number of kmodes models specified with range of clustering solutions.
#' @param data data used to fit kmodes models. All variables must be numeric with no missing values.
#' @param k_range range of clustering solutions to fit. Defaults to 1:4
#' @param seed optional random seed. Defaults to `Null`
#' @param weighted Optional weighted version of distance algorithm.
#'
#' @return
#' @export
#'
#' @examples fit_models(data, k_range = 4:6, seed = 1224, weighted = TRUE)
#'
#'
#'
fit_models <-

  function(data, k_range = 1:4, seed = NULL, weighted = FALSE ) {

    dplyr::tibble(
      k = k_range
    ) %>%
      dplyr::mutate(model = purrr::map(k, ~ {
        set.seed(seed) # changed to reset seed each iteration
        klaR::kmodes(data = data, modes = .x, iter.max = 20, weighted = weighted)
      }),
      gof = purrr::map(model, gof),
      cluster_distribution = purrr::map(model, cluster_dist),
      df = purrr::map(model, ~ add_clusters(model = .x, data = data)),
      attribute_distribution = purrr::map(model, ~ get_att_dist(model = .x, data = data)),
      table_attribute_distribution = purrr::map(model, table_att_dist),
      table_cluster_modes = purrr::map(model,~ table_cluster_modes(model = .x, data = data))
      )
  }
