df2<-df
df2$HourJ<-ifelse(df2$Hours<=40,'NormalWorkLoad','HugeWorkLoad')
wl<-sqldf('SELECT HourJ as WorkLoad, count(HourJ) as Count, sum(income) as Above from df2 group by HourJ')
wl$Below<-wl$Count-wl$Above
Percentage<-wl$Above/wl$Count
wl<-wl[,c(1,3,4)]
wlt<-melt(wl,id.vars = 'WorkLoad')
wl<-cbind(wl,Percentage)
gg<-ggplot(wlt,aes(x=WorkLoad,y=value,fill=variable))+geom_bar(stat = 'identity',position = 'stack')+theme_bw()+scale_fill_manual(values = c('red','green'))+theme(axis.text.x = element_text(angle = 45, hjust = 1))+ggtitle('Proportions of above-paid with different Work Load')
tbl <- tableGrob(t(wl[,c(1,4)]), rows=NULL)
grid.arrange(tbl, gg,
             nrow=2,
             as.table=TRUE,
             heights=c(1,4))
