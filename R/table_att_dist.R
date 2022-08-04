table_att_dist <- 
  function(model){
    
    att_dist <- get_att_dist(data,model) 
    
    cluster_dists <- cluster_dist(model)
    
    
    att_dist %>%
      tidyr::pivot_wider(names_from = cluster, 
                  values_from = prop, 
                  names_prefix = "Cluster ") %>%
      dplyr::group_by(var) %>%
      {
        dist <-
          cluster_dists %>%
          dplyr::select(-n) %>%
          tidyr::pivot_wider(names_from = cluster, values_from = proportion, names_prefix = "Cluster ") %>%
          dplyr::mutate(dplyr::across(dplyr::everything(), ~ (round(.x,2)*100)))
        
        dplyr::rename_with(., .cols = dplyr::starts_with("Cluster"), ~ paste0(.x,"\n", "(",dist[1,],"%)"))
      } %>%
      gt::gt() %>%
      gt::fmt_percent(columns = dplyr::starts_with("Cluster"), 
                  decimals = 0) %>%
      gt::cols_label(
        value = "Attributes"
      ) %>%
      gt::tab_header(title = "Attribute distribution by cluster assignment") %>%
      gt::data_color(columns = dplyr::starts_with("Cluster"),
                 colors = scales::col_numeric(domain = c(0,1),
                                              palette = c("#FEF0D9", "#990000"),
                                              alpha = .75))
  }
