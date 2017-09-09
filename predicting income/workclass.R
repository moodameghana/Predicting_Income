library(dplyr)
library(stats)
library(sqldf)
library(ggplot2)
library(reshape2)
library(gridExtra)
df<-read.csv("C:/Users/Mooda Meghana/Downloads/adult.csv")
summary(df)
df$income<-ifelse(df$income=='>50K',1,0)
df$workclass<-ifelse(df$workclass=='?','Unknown',as.character(df$workclass))
Work_class<-sqldf('SELECT workclass, count(workclass) as Count 
                  ,sum(income) as Above from df group by workclass')
table<-data.frame(Class=Work_class$workclass, Proportion=Work_class$Above/Work_class$Count)
Work_class$Below<-Work_class$Count-Work_class$Above
Work_class<-Work_class[,c(1,3,4)]
Workclass<-melt(Work_class,id.vars = 'workclass')
gg<-ggplot(Workclass,aes(x=workclass,y=value,fill=variable))+geom_bar(stat = 'identity',position = 'stack')+theme_bw()+scale_fill_manual(values = c('red','green'))+theme(axis.text.x = element_text(angle = 45, hjust = 1))+ggtitle('Proportions of above-paid within different classes')
tbl <- tableGrob(t(table), rows=NULL)
grid.arrange(tbl, gg,
             nrow=2,
             as.table=TRUE,
             heights=c(1,4))

