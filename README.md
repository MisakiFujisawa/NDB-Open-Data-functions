# 国立長寿医療研究センター医療経済研究部のGithubアカウントです。NDBオープンデータの分析に役立つ関数を公開しています。

### scr_cal()　

NDBオープンデータと人口動態統計からSCRを計算するための関数です。以下の4つのデータフレームを渡し、各都道府県別のSCRが出力されます。　　

1.  sinryou_agesex　3列 age, sex, sinryou

2.  sinryou_pref　2列 sinryou, prefname

3.  population_agesex　3列 age, sex, population

4.  population_pref　4列 prefname, age, sex, population
