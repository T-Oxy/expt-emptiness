library("imager")

List <- c(1,2,10,3,9,4,8,5,7,6)  #循環法における、番号0の時の順序

s <- readline("順序番号を入力：")  #順序番号を指定
n <- as.integer(s)  #文字列を数値に

for(i in 1:10){
  k <- as.character(((List[i]+n)%%10))  #画像の表示順を決定し、その数値を文字列に変換
  name <- paste(k,".png",sep="")  #数値を文字列にし、文字列結合して名前生成
  img=load.image(name)  #指定した名の画像を読み込み
  plot(img, xaxt="n",axes=FALSE)  #第1引数で画像表示, 第2引数で軸/目盛りを非表示にする
  mtext(paste("写真",i,sep=""),outer=FALSE,side=3,cex=2,line=1)  #写真のキャプションを図外の上に表示
  #  Sys.sleep(50)  #50秒画像を表示する
  readline()  #キーボードを押したら次の画像へ
}
