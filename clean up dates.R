rm(list=ls())

library(lubridate)
library(dplyr)

setwd("Z:\\DOCUMENTATION\\BART\\R\\R_DEV\\marine_science\\Marine-Science")

## get data in
cf <- count.fields("data\\Coral.txt")
ind <- cf[2]- 14
dfr <- read.table("data\\Coral.txt", skip = 1, stringsAsFactors = FALSE,
                 colClasses = c(rep("character", 8), rep("numeric", 6),
                                rep("character", ind)))
a <- paste0(dfr[1,15], " ", dfr[1,16], " ", dfr[1,17])
dfr[,15] <- a
df <- dfr[,1:15]
rnames <- c("BYYY", "BM", "BD", "BH", "EYYY", "EM", "ED", "EH", "SST", "SSTANOM",
            "HOTSPOT", "DHW", "Lat", "Long", "Reef_Name")
names(df) <- rnames

## dates
bd <- dmy(paste0(df[,3], df[,2], df[,1]))
ed <- dmy(paste0(df[,7], df[,6], df[,5]))
df$Bdate <- bd
df$Edate <- ed

## write function

list.files(".//data//")


x = "Eight"
clean_txt <- function(x){
        path <- paste0("data\\", x, ".txt")
        cf <- count.fields(path)
        ind <- cf[2]- 14
        dfr <- read.table(paste0("data\\", x, ".txt"), skip = 1,
                          stringsAsFactors = FALSE, colClasses = c(rep("character", 8),
                                                                   rep("numeric", 6),
                                                                   rep("character", ind)))
        a <- paste0(dfr[1,15], " ", dfr[1,16], " ", dfr[1,17], " ", dfr[1,18])
        dfr[,15] <- a
        df <- dfr[,1:15]
        rnames <- c("BYYY", "BM", "BD", "BH", "EYYY", "EM", "ED", "EH", "SST", 
                    "SSTANOM","HOTSPOT", "DHW", "Lat", "Long", "Reef_Name")
        names(df) <- rnames
        df$Bdate <- dmy(paste0(df[,3], df[,2], df[,1]))
        df$Edate <- dmy(paste0(df[,7], df[,6], df[,5]))
        cdf <- df %>%
                mutate(Bmth = month.abb[as.numeric(BM)], 
                       Emth = month.abb[as.numeric(EM)]) %>%
                select(Bdate, BYYY, Bmth, Edate, EYYY, Emth, SST)
        write.table(cdf, paste0("data\\", x, "_", "clean.txt"), 
                    quote = FALSE, row.names = FALSE)
        
}


if(ind == 2){
        a <- paste0(dfr[1,15], " ", dfr[1,16])
} else {
        if(ind == 3){
                a <- 
        }
}


if(ind == 2){
        a <- paste0(dfr[1,15], " ", dfr[1,16])
} else {
        if(ind == 3){
                a <- paste0(dfr[1,15], " ", dfr[1,16], " ", dfr[1,17])
        } else { a <- paste0(dfr[1,15], " ", dfr[1,16], " ", dfr[1,17], " ", dfr[1,18])}
}