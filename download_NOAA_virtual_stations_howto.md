download NOAA virtual stations
========================================================
**Bart Huntley 31/03/2015**

This is a *how to* document to accompany the R script *download_NOAA_virtual_stations.R*

Put the script in your working directory.

Ensure the .txt file named *virtual_stations_list.txt* is also in your working directory.

Clear your environment:

```r
rm(list=ls())
```

Set your working environment. Copy and paste your filepath. Either change the single back slash to two or swap the backslashes to forward slashes in the filepath.

```r
setwd("your file path goes here")
```


Create a folder for your downloads:

```r
if(!file.exists("data")){ dir.create("data")}
```


Load helper function to find url path/s:

```r
find_url <- function(x){
        if(x == "All") {
                url <- vsl
        } else {
                ind <- grep(x, vsl[,1])
                url <- vsl[ind,1]
        }
        return(as.data.frame(url, stringsAsFactors = FALSE))
}
```


Read in virtual stations (NOTE - If new virtual stations are added, this list must be updated along with the virtual station choices as below):

```r
vsl <- read.table("virtual_stations_list.txt", colClasses = "character")
```


The CURRENT VIRTUAL STATION CHOICES

"MontgomeryReef"

"RowleyShoals"

"EightyMileBeach"

"DampierArchipelago"

"MontebelloIslands"

"Ningaloo"

"CoralBay"

"SharkBay"

"JurienBay"

"Marmion"

"ShoalwaterIslands"

"NgariCapes"

"All"

The parameter that you give to the function must be one of the above with " "s (suggest just copy and paste). "All" will download all stations at same time.

Create the url object using the helper function with **YOUR** choice of station/s:

```r
url <- find_url("your choice  goes here")
```


Run loop to download required station data:

```r
for(i in 1:length(url[,1])){
        download.file(url[i,1], destfile = paste0("./data/", substr(url[i,1], 76, 80), ".txt"))
}
```

**NOTE**
- The loop downloads the station data as tab separated text files into a folder called "data"
- The station data will be given a short name
- Subsequent iterations of the loop will overide prior downloads
