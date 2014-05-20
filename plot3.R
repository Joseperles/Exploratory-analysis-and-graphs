#Loading data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
sapply(NEI, class)
#subsert data
baltimore<-subset(NEI,fips=="24510")
head(baltimore)
#requiere package plyr
library(plyr) 
#aagregating by year and type of emissions
emissionsbyyear<-ddply(baltimore,~year+type,summarise,sum=sum(Emissions, na.rm=T))
emissionsbyyear
#require plackage ggplot2
library(ggplot2)
png(file="plot3.png")
emissionsbyyear$type<-as.factor(emissionsbyyear$type)
emissionsbyyear<-within(emissionsbyyear, year<-factor(year,labels=c("1999","2002","2005","2008")))
ggplot(data=emissionsbyyear, aes(x=year, y=sum, fill=type))+geom_bar(stat="identity", position=position_dodge())+xlab("Total emissions by year from all sources")+ylab("PM2.5 emitted, in tons")+ggtitle("Baltimore City Emissions by year")
dev.off()