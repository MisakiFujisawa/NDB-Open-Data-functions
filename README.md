# ndbtoolsパッケージ
NDBオープンデータの分析に役立つ関数を公開しています。

## get_population()
estat apiを使って国勢調査の人口推計データを取得。
総務省estatのサイトでユーザー登録が必要。https://www.e-stat.go.jp/api/
以下2つの引数を指定。

・apikey　=　estatのapiキー

・time　=　取得したい人口推計の年

## scr_cal()
Standardized Claim Ration（標準化レセプト出現比）を計算。
