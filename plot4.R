#Loading data
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
sapply(NEI, class)
#Merge data and select Coal Combustion using Grep function
merge<-merge(SCC,NEI,by.x="SCC",by.y="SCC", all=FALSE)
coal<-merge[grep("Coal", merge$EI.Sector, perl=TRUE),]
#requiere package plyr
library(plyr) 
#aagregating by year and type of emissions
emissionsbyyear.coal<-ddply(coal,~year,summarise,sum=sum(Emissions, na.rm=T))
emissionsbyyear.coal
#require plackage ggplot2
library(ggplot2)
png(file="plot4.png")
emissionsbyyear.coal<-within(emissionsbyyear.coal, year<-factor(year,labels=c("1999","2002","2005","2008")))
ggplot(data=emissionsbyyear.coal, aes(x=year, y=sum))+geom_bar(stat="identity")+ xlab("Total emissions by year from Coal Combustion Sources")+ylab("PM2.5 emitted, in tons")+ggtitle("USA Emissions by year: Coal Combustion Sources")
dev.off()