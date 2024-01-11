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

・

# Functions for NDB

## 作成予定の関数

・入退院日の推定関数：入院料の加算傾向の表示と推定入退院日計算

　　個人識別ID、診療行為、特定の加算

　　SI、IY、TO、CDの最終行為発生日　

・横持ち日付列を一列に変換（IDなどグループ指定、対象日付）　

　　　横持ち日付列（「1日の情報」-「30日の情報」＋ 診療年月） →　1列の日付に変換

・日付列から解析対象となる日付を抽出

　　　①期間中最初の日付、②度数、③日付間の間隔、

・縦持ち日付列から開始列・終了列を作成

医薬品処方日・診療行為実施日：　開始日に変換したい

　→　ある期間内で実施日があるか？
