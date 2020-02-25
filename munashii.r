#ライブラリ
library(RMeCab)
library(pipeR)
library(dplyr)
library(rtweet)

#ツイート取得、ファイル書き込み
x<- search_tweets("むなしい OR 空しい OR 虚しい",n=3000, include_rts=FALSE, langs = "ja")
write.csv(x$text,file = "t_munashii_2.csv",sep = ",", col.names=TRUE , row.names=FALSE)

# 単語感情極性表(Semantic Orientations of Words)の読み込み
sow <- read.table("http://www.lr.pi.titech.ac.jp/~takamura/pubs/pn_ja.dic",sep=":",
                  col.names=c("term","kana","pos","value"),
                  colClasses=c("character","character","factor","numeric"),
                  fileEncoding="Shift_JIS")

#データ加工、スコア算出
word <- RMeCabFreq("t_munashii_2.csv")
word2 <- subset(word,Term %in% sow$term)
word2 <-  merge(word2,sow,by.x = c("Term","Info1"),by.y = c("term","pos"))
word2 <- word2[4:(ncol(word2)-2)]*word2$value

#結果を描画
word2 <-c(sum(word2 > 0.5 & word2 < 1.0),
               sum(word2 > 0 & word2 < 0.5),
               sum(word2 > -0.5 & word2 < 0),
               sum(word2 > -1.0 & word2 < -0.5)) %>>%
as.data.frame()

dv=c(word2[1:4,])
pie(dv,radius=1,labels=c(paste("ポジティブ(0.5~1):",dv[1]),
                         paste("ややポジティブ(0~0.5):",dv[2]),
                         paste("ややネガティブ(-0.5~0):",dv[3]),
                         paste("ネガティブ(-1~-0.5):",dv[4])),col=c("#08519c","#3182bd","#6baed6","#9ecae1"),
                        clockwise=T,border="#ffffff", main="むなしい OR 虚しい OR 空しい" , cex.main=1)
