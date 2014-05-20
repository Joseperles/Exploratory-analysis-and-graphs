#Loading data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
sapply(NEI, class)
#subset data Baltimore and L. Angeles and subset ON-Road type corresponding to motor vehicle
baltimore.la<-subset(NEI,fips=="24510" | fips=="06037")
baltimore.la.onroad<-subset(baltimore.la, type=="ON-ROAD")
#requiere package plyr
library(plyr) 
#aagregating by year and type of emissions
emissionsbyyear.onroad<-ddply(baltimore.la.onroad,~year+fips,summarise,sum=sum(Emissions, na.rm=T))
emissionsbyyear.onroad
#require plackage ggplot2
library(ggplot2)
png(file="plot6.png")
emissionsbyyear.onroad$fips<-as.factor(emissionsbyyear.onroad$fips)
emissionsbyyear.onroad<-within(emissionsbyyear.onroad, year<-factor(year,labels=c("1999","2002","2005","2008")))
ggplot(data=emissionsbyyear.onroad, aes(x=year, y=sum, fill=fips))+geom_bar(stat="identity", position=position_dodge())+xlab("Total emissions by year from Cars.     06037:L.Angeles  24510:Baltimore")+ylab("PM2.5 emitted, in tons")+ggtitle("Baltimore City and L.A. Emissions by year from Car source (On-Road Type)")
dev.off()