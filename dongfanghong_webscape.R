

library(jsonlite)
library(httr)
library(XML)

url.upper.part <- "http://www.dfham.com/funds-struts/fund-net-chart-table/001564?from=&to=&page="

url.down.part <- "-16&show=1"


for(i in 1:28){
        url <- paste0(url.upper.part, i ,url.down.part)
        
        table.data <- readHTMLTable(url)
        
        df <- table.data[[1]]
        
        if(i == 1){
                result <- df[,c(1, 3)]
        } else if(i > 1){
                result <- rbind(result, df[,c(1, 3)])
                
        }
        
}



View(result)

setwd("D:\\MyR\\dongfanghong")

write.csv(result, "dongfanghongjingzhi.csv")
#
############

original.data <- read.csv("dongfanghongjingzhi.csv")
View(original.data)

names(original.data[-1]) <- c("valdate", "totalnetvalue")

final.result <- tapply(original.data[[3]], 
                       as.character(substr(original.data[[2]], 1, 7)), 
                       head, n = 1)
View(final.result)
# 
write.csv(data.frame(final.result), "dongfanghongmonthlyjingzhi.csv")
