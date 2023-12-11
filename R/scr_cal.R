#argument dataset
#sinryou_agesex　 　3col：age, sex, sinryou
#sinryou_pref　     2col：sinryou, prefname
#population_agesex　3col：age, sex, population
#population_pref　  4col：prefname, age, sex, population

#計算式　標準化レセプト出現比 SCR = 都道府県別レセプト数/期待レセプト数　　　　　
#.       期待レセプト数 = Σ（都道府県別5際階級性別人口✖️基準レセプト数）
#.       基準レセプト数 = 日本全体の5歳階級性別レセプト数/日本全体の5歳階級性別人口

library(tidyverse)
scr_cal <- function(sinryou_agesex, sinryou_pref, population_agesex, population_pref){

  # Check if sinryou_agesex is empty
  if (nrow(sinryou_agesex) == 0||nrow(sinryou_pref)==0) {
    warning("sinryou_agesex is empty. Function will return NULL.")
    return(NULL)
  }

  #基準レセプト請求数
  scr <- sinryou_agesex %>%
    full_join(population_agesex) %>%
    mutate(standard_rece=sinryou/(population*1000)) %>%
    select(age,sex,standard_rece) %>% ungroup()

  #期待レセプト請求数
  scr1 <- population_pref %>% left_join(scr) %>%
    mutate(expect_rece=population*1000*standard_rece) %>%
    select(prefname, expect_rece) %>%
    group_by(prefname) %>%
    summarise(across(everything(),sum)) %>%
    mutate(prefname=str_trim(prefname,side="both")) %>%
    ungroup()

  scr2 <- sinryou_pref %>% full_join(scr1) %>%
    mutate(scr=sinryou*100/expect_rece) %>%
    select(prefname,scr)

  return(scr2)

}





