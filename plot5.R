#Loading data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
sapply(NEI, class)
#subsert data Baltimore and OND-Road type corresponding to motor vehicle
baltimore.onroad<-subset(NEI,fips=="24510" & type=="ON-ROAD")
head(baltimore.onroad)
#requiere package plyr
library(plyr) 
#aagregating by year and type of emissions
emissionsbyyear.onroad<-ddply(baltimore.onroad,~year,summarise,sum=sum(Emissions, na.rm=T))
emissionsbyyear.onroad
#require plackage ggplot2
library(ggplot2)
png(file="plot5.png")
emissionsbyyear<-within(emissionsbyyear.onroad, year<-factor(year,labels=c("1999","2002","2005","2008")))
ggplot(data=emissionsbyyear.onroad, aes(x=year, y=sum))+geom_bar(stat="identity")+ xlab("Total emissions by year from ON-Road (Vehicles)")+ylab("PM2.5 emitted, in tons")+ggtitle("Baltimore City Emissions by year: Vehicles (On-Road)")
dev.off()