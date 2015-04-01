### Script written for Marine Science to reproducibly download
### NOAA Coral Reef Watch Virtual Station Data.
### Bart Huntley 31/03/2015

## Clear working environment of variables
rm(list=ls())

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


