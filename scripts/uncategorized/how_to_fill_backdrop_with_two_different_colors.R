require(ggplot2)
test<-data.frame(a=c('1','1','2','2'),b=c(2,-2,4,-3),d=c('m','n','m','n')) 
x <- rep(seq(1,2),2)
test$panel <- x
test$colorindicator = ifelse(test$b<0,"negative","positive")
p=ggplot(data=test,aes(x=a,y=b))
p = p + geom_rect(aes(fill = colorindicator), xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf, alpha = 1) 
p = p + geom_bar(fill='deeppink',color="black",position=position_dodge(),stat='identity',width=0.5)
p = p + facet_grid(.~panel,scales="free")
print(p)
p
