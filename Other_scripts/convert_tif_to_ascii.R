# package
# if need to install it use: install.packages("raster")
library(raster)

# change names of files as needed

# define your working directory (here is your folder with rasters)
setwd("Your/directory")

# listing files (you need the folder with all your tif files)
all_files <- list.files(path = "Folder_with_rasters", pattern = "tif$",
                        full.names = TRUE)

# stacking rasters (if this does not work, copy errors and send them to us)
all_rasters <- stack(all_files)

# writing back rasters in ascii format
## new folder for ascii files
dir.create("Folder_with_ascii")

## names of files
namesr <- paste0("Folder_with_ascii/",
                 names(all_rasters), ".asc")

## writing (this is an lapply loop to do all at once)
rw <- lapply(1:length(namesr), function(x) {
  writeRaster(all_rasters[[x]], filename = namesr[x], format = "ascii")
})
