# Functions for NDB open data

### reshape_ndbop()

ダウンロードしたNDBオープンデータをデータフレームに処理する関数です。

都道府県・性年齢別のデータに対して適用可能です。

使用する際はR/reshape_ndbop.RのコードをRスクリプトにコピーしてsource()で読み込んでください。

＊2次医療圏などの形式には未対応です

```{r}
library("tidyverse")
library("readxl")
source("function/reshape_ndbop.R")

dt <- read_excel("ファイルパス")
ndbop <- reshape_ndbop(dt)
```
