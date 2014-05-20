#Loading data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
sapply(NEI, class)
#requiere package plyr
library(plyr) 
#make the histogram
emissionsbyyear<-ddply(NEI,~year,summarise,sum=sum(Emissions, na.rm=T))
emissionsbyyear
png(file="plot1.png")
barplot(emissionsbyyear$sum,  main="Emissions by year", xlab="Total emissions by year from all sources", ylab="PM2.5 emitted, in tons")
axis(1, at=c(1,2,3,4),labels=c("1999","2002","2005","2008")) #using the positions for each day as x
dev.off()