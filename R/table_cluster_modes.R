table_cluster_modes <-
  function(data,model) {

    df <- add_clusters(data,model)

    modes <-
      model$modes %>%
      tibble::rownames_to_column(var = "cluster") %>%
      tidyr::pivot_longer(- cluster,
                   names_to = "vars") %>%
      dplyr::select(cluster,
                    vars,
                    "mode" = value) %>%
      dplyr::mutate(cluster = factor(cluster))

    cluster_distribution <- cluster_dist(model)

    df %>%
      tidyr::pivot_longer(-cluster, names_to = "vars") %>%
      dplyr::arrange(cluster,vars,value) %>%
      dplyr::distinct(cluster,vars,value) %>%
      dplyr::left_join(modes) %>%
      dplyr::mutate(mode_r = dplyr::if_else(value == mode, "check", "NA")) %>%
      dplyr::select(-mode) %>%
      tidyr::pivot_wider(names_from = cluster,
                  values_from = mode_r,
                  names_prefix = "Cluster ") %>%
      {
        dist <-
          cluster_distribution %>%
          dplyr::select(cluster,proportion) %>%
          tidyr::pivot_wider(names_from = cluster, values_from = proportion, names_prefix = "Cluster ") %>%
          dplyr::mutate(dplyr::across(dplyr::everything(), ~ (round(.x,2)*100)))
        dplyr::rename_with(., .cols = dplyr::starts_with("Cluster"), ~ paste0(.x,"\n", "(",dist[1,],"%)"))
      }  %>%
      dplyr::group_by(vars) %>%
      gt::gt() %>%
      gt::tab_header(title = "Cluster modes") %>%
      gt::cols_label(value = "Attributes") %>%
      {
        n_clusters <- as.numeric(length(model$size))+2

        cols <- as.character(3:n_clusters)
        args <- c()

        for(i in cols){
          args[i] <- paste0("gtExtras::gt_fa_column(.,column =",i,",align = 'center')")
        }


        args <- paste(args, collapse = "%>%")

        eval(parse(text = args))
      }

  }
