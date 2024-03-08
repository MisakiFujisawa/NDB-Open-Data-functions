# Functions for NDB open data

## get_population()

This function uses the e-Stat API to obtain population estimate data from the Census. User registration is required at the e-Stat site.

<https://www.e-stat.go.jp/api/>

・api_key　=　your e-stat api key

・time　=　Population Estimation Data Year

## scr_ndbop()

Standardized Claim Ratio（標準化レセプト出現比）を計算。

・sinryou_agesex　　　　性年齢別 NDB オープンデータ（3col：age, sex, sinryou）

・sinryou_pref　　　 　　都道府県別 NDBオープンデータ（2col：sinryou, prefname）

・population_agesex　　日本全体の人口推計データ（3col：age, sex, population）

・population_pref　　　都道府県の人口推計データ（4col：prefname, age, sex, population）

### reshape_ndbop()

Converting ndb open data to data frames

・data　　　　NDB Open Dataのファイルパス
