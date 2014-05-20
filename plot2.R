#Loading data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
sapply(NEI, class)
#subsert data
baltimore<-subset(NEI,fips=="24510")
head(baltimore)
#requiere package plyr
library(plyr) 
#make the histogram
emissionsbyyear<-ddply(baltimore,~year,summarise,sum=sum(Emissions, na.rm=T))
emissionsbyyear
png(file="plot2.png")
barplot(emissionsbyyear$sum,  main="Baltimore City emissions by year", xlab="Total emissions by year from all sources", ylab="PM2.5 emitted, in tons")
axis(1, at=c(1,2,3,4),labels=c("1999","2002","2005","2008")) #using the positions for each day as x
dev.off()