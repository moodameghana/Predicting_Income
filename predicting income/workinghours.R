colnames(df)[13]<-'Hours'
gg<-qplot(Hours, data=df, geom="histogram")+theme_bw()+ggtitle('Histogram of Working Hours')
gg
