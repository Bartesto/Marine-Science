rm(list=ls())

library(lubridate)

setwd("Z:\\DOCUMENTATION\\BART\\R\\R_DEV\\marine_science\\Marine-Science")

## get data in
dfr <- read.table("data\\Coral.txt", skip = 1, stringsAsFactors = FALSE,
                 colClasses = c(rep("character", 8), rep("numeric", 6),
                                rep("character", 3)))
a <- paste0(dfr[1,15], " ", dfr[1,16], " ", dfr[1,17])
dfr[,15] <- a
df <- dfr[,1:15]
rnames <- c("BYYY", "BM", "BD", "BH", "EYYY", "EM", "ED", "EH", "SST", "SSTANOM",
            "HOTSPOT", "DHW", "Lat", "Long", "Reef_Name")
names(df) <- rnames

## dates
bd <- ymd(paste0(df[,1], df[,2], df[,3]))
ed <- ymd(paste0(df[,5], df[,6], df[,7]))
df$Bdate <- bd
df$Edate <- ed
