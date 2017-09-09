adult <- table(adult$education, adult$income)
barplot(adult, main="Education Vs Income",
        xlab="Income", col=c("darkblue","red"),
        legend = rownames(adult), beside=TRUE)


