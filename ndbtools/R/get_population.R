pacman::p_load(estatapi, tidyverse)

get_population <- function(api_key, time) {
  # データ取得と処理の関数
  process_data <- function(statsDataId) {
    estatapi::estat_getStatsData(appId = api_key, statsDataId = statsDataId, lvArea = "2") %>%
      filter(人口 == "総人口" & 男女別 != "男女計" & 年齢5歳階級 != "総数") %>%
      select(年齢5歳階級, 男女別, '全国・都道府県', '時間軸（年月日現在）', value) %>%
      rename(age = 年齢5歳階級,
             sex = 男女別,
             prefname = '全国・都道府県',
             time = '時間軸（年月日現在）') %>%
      group_by('時間軸（年月日現在）') %>%
      split(.$time)
  }

  # データの取得
  pop <- process_data("0003459027") # 2015-2019年
  pop2 <- process_data("0003448237") # 2020-2022年

  # すべての年のデータを一つのリストに結合し、名前を付ける
  all_pop <- c(pop, pop2)
  names(all_pop) <- as.character(2015:2022)

  # 指定された年のデータを返す
  if (as.character(time) %in% names(all_pop)) {
    return(all_pop[[as.character(time)]])
  } else {
    stop("指定された年の人口推計は存在しません。")}
}


#
# get_population <- function(api_key, time){
#
#   # population_list <- estatapi::estat_getStatsList(appId = api_key,
#   #                                                 searchWord = "人口推計 AND 都道府県 AND 年齢 AND 男女")
#   # meta2015_2019 <- estat_getMetaInfo(api_key, "0003459027")
#   # meta2015_2019
#
#   # meta2020_2022 <- estat_getMetaInfo(api_key, "0003448237")
#   # meta2020_2022
#
#
#   pop_2015_2019 <- estatapi::estat_getStatsData(appId = api_key, statsDataId = "0003459027",
#                                                 lvArea="2")
#   pop_2020_2022 <- estatapi::estat_getStatsData(appId = api_key, statsDataId = "0003448237",
#                                                 lvArea="2")
#
#   pop <- pop_2015_2019 %>% filter(人口=="総人口"&
#                                     男女別!="男女計"&
#                                     年齢5歳階級!="総数") %>%
#     select(年齢5歳階級,男女別,'全国・都道府県','時間軸（年月日現在）',value) %>%
#     rename(age=年齢5歳階級,sex=男女別,prefname='全国・都道府県',time='時間軸（年月日現在）') %>%
#     group_by('時間軸（年月日現在）') %>% split(.$time)
#
#   pop2 <- pop_2020_2022 %>% filter(人口=="総人口"&
#                                      男女別!="男女計"&
#                                      年齢5歳階級!="総数") %>%
#     select(年齢5歳階級,男女別,'全国・都道府県','時間軸（年月日現在）',value) %>%
#     rename(age=年齢5歳階級,sex=男女別,prefname='全国・都道府県',time='時間軸（年月日現在）') %>%
#     group_by('時間軸（年月日現在）') %>% split(.$time)
#
#   pop2015 <- pop[[1]]
#   pop2016 <- pop[[2]]
#   pop2017 <- pop[[3]]
#   pop2018 <- pop[[4]]
#   pop2019 <- pop[[5]]
#   pop2020 <- pop2[[1]]
#   pop2021 <- pop2[[2]]
#   pop2022 <- pop2[[3]]
#
#   # 引数に基づいてデータフレームを選択
#   if (time == 2015) {
#     return(pop2015)
#   } else if (time == 2016) {
#     return(pop2016)
#   } else if (time == 2017) {
#     return(pop2017)
#   } else if (time == 2018) {
#     return(pop2018)
#   } else if (time == 2019) {
#     return(pop2019)
#   } else if (time == 2020) {
#     return(pop2020)
#   } else if (time == 2021) {
#     return(pop2021)
#   } else if (time == 2022) {
#     return(pop2022)
#   } else {
#     stop("指定された年の人口推計は存在しません。")}
# }
