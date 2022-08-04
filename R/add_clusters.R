add_clusters <-
  function(data,model,...) {
    data %>%
      dplyr::mutate(cluster = model$cluster,
             dplyr::across(dplyr::everything(),~ as.factor(.x))) %>%
      dplyr::relocate(cluster)
  }
