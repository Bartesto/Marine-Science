### Script written for Marine Science to reproducibly "clean"
### NOAA Coral Reef Watch Virtual Station Data.
### Bart Huntley 01/04/2015

### CONDITIONS - This script is to be run after download_NOAA_virtual_stations.R
### has been run. 

## Clear working environment of variables
rm(list=ls())

## Check for required packages and install and load if not present
is_installed <- function(mypkg) is.element(mypkg, installed.packages()[,1])
load_or_install<-function(package_names)  
{  
        for(package_name in package_names)  
        {  
                if(!is_installed(package_name))  
                {  
                        install.packages(package_name,repos="http://cran.csiro.au/")  
                }  
                library(package_name,character.only=TRUE,quietly=TRUE,verbose=FALSE)  
        }  
}  
load_or_install(c("lubridate","dplyr","tools"))

## Set your working environment. Copy and paste your filepath. Either 
## change the single back slash to two or swap the backslashes to forward 
## slashes in the filepath.
setwd("your file path goes here")

## Create folder for downloaded data
if(!file.exists("data")){ dir.create("data")}

## Helper function to find appropriate url address
find_url <- function(x){
        if(x == "All") {
                url <- vsl
        } else {
                ind <- grep(x, vsl[,1])
                url <- vsl[ind,1]
        }
        return(as.data.frame(url, stringsAsFactors = FALSE))
}

## Read in Virtual stations (NOTE - If new stations are added this list must
## be updated along with station choice as below)
vsl <- read.table("virtual_stations_list.txt", colClasses = "character")

## CURRENT VIRTUAL STATION CHOICES
## "MontgomeryReef"
## "RowleyShoals"
## "EightyMileBeach"
## "DampierArchipelago"
## "MontebelloIslands"
## "Ningaloo"
## "CoralBay"
## "SharkBay"
## "JurienBay"
## "Marmion"
## "ShoalwaterIslands"
## "NgariCapes"
## The parameter that you give to the function must be one of the above with
## " "s (suggest just copy and paste) or "All" which will download all stations
## at same time.


url <- find_url("your choice  goes here")

for(i in 1:length(url[,1])){
        download.file(url[i,1], destfile = paste0("./data/", substr(url[i,1], 76, 80), ".txt"))
}

## Obtain list of downloaded text files (no ext)
mylist <- basename(file_path_sans_ext(list.files(".//data//")))

## Function to data munge!! for single txt file
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
        write.csv(cdf, paste0("data\\", x, "_", "clean.csv"), 
                  quote = FALSE, row.names = FALSE)
        
}

## Vectorise for speed over list of multiple txt files
sapply(mylist, clean_txt)
