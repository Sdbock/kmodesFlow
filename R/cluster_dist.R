cluster_dist <-
  function(model) {
    model$size %>%
      tibble::as_tibble() %>%
      dplyr::mutate(total = sum(n),
             proportion = n/total) %>%
      dplyr::select(cluster, proportion, n)
  }
