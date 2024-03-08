library(readxl)
library(tidyverse)

reshape_ndbop <- function(data, dev = FALSE){
  if(dev) browser()

  # NAの行を削除し、列名を作成
  first_column <- str_remove(data[[1]], "\\r\\n")
  row_hyou_start <- which(str_detect(first_column, "薬効分類"))
  row_data_start <- which(!is.na(data[[2]]))[2]

  colname <- data %>%
    slice(row_hyou_start:(row_data_start - 1)) %>%
    t() %>%
    as_tibble(.name_repair = "unique") %>%
    fill(everything()) %>%
    mutate(across(everything(), ~replace_na(.,""))) %>%
    unite(col = "united", everything(), na.rm = TRUE) %>%
    pull(united) %>%
    str_replace_all(., "_+$", "") %>%
    str_replace_all(., "\r\\n", "")



  # データ構造に基づく処理の分岐
  # ----------性年齢別のデータの場合-------------------------------------------------
  if(any(str_detect(colname, "0～4歳"))) {
    reshape_targets <- colname[1:(min(which(str_detect(colname, "0～4歳")))-1)]
    reshaped_data <- data %>%
      slice(row_data_start:nrow(.)) %>%
      setNames(colname) %>%
      fill(reshape_targets[1:2]) %>%
      mutate(across(everything(), ~if_else(.=="-", NA_character_, .))) %>%
      pivot_longer(cols = !c(all_of(reshape_targets)),
                   names_to = c("性別", "年齢"),
                   names_sep = "_",
                   values_to = "value") %>%
      mutate(val2 = as.numeric(value))

    # NAのチェックと警告の生成
    check_na <- reshaped_data %>%
      filter(is.na(val2) & !is.na(value)) %>%
      nrow()

    message <- str_c("NA generated in val2 is ", check_na)
    if (check_na > 0) {
      warning(str_c(message, " data is saved in obj"))
      obj <<- data
    } else {
      message(message)
    }

    reshaped_data <- reshaped_data %>%
      mutate(value = val2) %>%
      select(-val2)

    return(reshaped_data)



 # ------都道府県データの場合--------------------------------------------------------------
  } else if(any(str_detect(colname, "北海道"))) {
    # "北海道"を含む行が一つでもあれば実行する処理
    reshape_targets <- colname[1:(min(which(str_detect(colname, "北海道")))-1)]
    reshaped_data <- data %>%
      slice(row_data_start:nrow(.)) %>%
      setNames(colname) %>%
      fill(reshape_targets[1:2]) %>%
      mutate(across(everything(), ~if_else(.=="-", NA_character_, .))) %>%
      pivot_longer(cols = !c(all_of(reshape_targets)),
                   names_to = c("番号", "都道府県"),
                   names_sep = "_",
                   values_to = "value") %>%
      mutate(val2 = as.numeric(value))

    # NAのチェックと警告の生成
    check_na <- reshaped_data %>%
      filter(is.na(val2) & !is.na(value)) %>%
      nrow()

    if (check_na > 0) {
      warning("NA generated in val2; inspect returned data for details.")
      # warning(str_c(message, " data is saved in obj"))
    }

    reshaped_data <- reshaped_data %>%
      mutate(value = val2) %>%
      select(-val2)

    return(reshaped_data)


  } else {
    # 上記のどちらも含まない場合の処理
    stop("Error: The data does not contain '0～4歳' or '北海道'.")
  }

}

# data <- read_excel("data/ndb_open/第8回性年齢別薬効分類.xlsx")
# data <- read_excel("data/ndb_open/第8回都道府県別薬効分類.xlsx")
# dt <- reshape_ndbop(read_excel("data/ndb_open/第8回性年齢別薬効分類.xlsx"))
# dt <- reshape_ndbop(read_excel("data/ndb_open/第8回都道府県別薬効分類.xlsx"))
