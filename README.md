# ndbtoolsパッケージ
NDBオープンデータの分析に役立つ関数を公開しています。

## get_population()
estat apiを使って国勢調査の人口推計データを取得。
総務省estatのサイトでユーザー登録が必要。https://www.e-stat.go.jp/api/

・apikey　=　estatのapiキー

・time　=　取得したい人口推計の年

## scr_cal()
Standardized Claim Ratio（標準化レセプト出現比）を計算。

・sinryou_agesex　　　　　3col：age, sex, sinryou

・sinryou_pref　　　　　2col：sinryou, prefname

・population_agesex　　　　　　　3col：age, sex, population

・population_pref　　　　　　　4col：prefname, age, sex, population

