rm(list=ls())

setwd("Z:\\DOCUMENTATION\\BART\\R\\R_DEV\\marine_science\\Marine-Science")

## get data in
df <- read.table("data\\Coral.txt", skip = 1, stringsAsFactors = FALSE)
a <- paste0(df[1,15], " ", df[1,16], " ", df[1,17])
df[,15] <- a
df <- df[,1:15]
rnames <- c("BYYY", "BM", "BD", "BH", "EYYY", "EM", "ED", "EH", "SST", "SSTANOM",
            "HOTSPOT", "DHW", "Lat", "Long", "Reef_Name")
names(df) <- rnames


