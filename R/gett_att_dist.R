get_att_dist <-
  function(data,model,...) {
    df <- add_clusters(data,model) # creating new df with full data and cluster assignment
    
    props <- 
      df %>% 
      tidyr::pivot_longer(-cluster,
                   names_to = "var") %>% # reshaping to long format
      dplyr::group_by(cluster,var) %>%
      dplyr::count(value) %>% 
      dplyr::mutate(total = sum(n)) %>%
      dplyr::mutate(prop = n / sum(n)) %>% # calculating proportions
      dplyr::distinct(cluster,var,value,prop) %>%
      dplyr::arrange(cluster, var) %>%
      dplyr::mutate(prop = round(prop,3),
             cluster = factor(cluster)) %>% # rounding proportions
      dplyr::ungroup()
    
    return(props)
    
  }
