# r packages needed
# if you need to install the packages use install.packages("package_name")
library(raster)
library(rgdal)

# defined your directory
setwd("YOUR/DIRECTORY")

# listing the files you want to mask (place them in subfolder so it is easier to
# find them) in my case the folder is "test_folder" (change it accordingly)
list_files <- list.files(path = "test_folder", pattern = ".tif$",
                         full.names = TRUE)

# now lets create a stak of all raster layers
list_rasters <- stack(list_files)


# read you mask layer
## use this if your mask is a raster layer (change name of layer accordingly)
mask_raster <- raster("base_layer.tif")

## us this if ypur mask is a shapefile (change name of layer accordingly)
mask_shp <- readOGR(dsn = ".", layer = "names_shpfile")


# now the masking process
## first corp the layers to reduce the extent
cropped <- crop(list_rasters, mask_raster)

## second mask the layer
masked <- mask(cropped, mask_raster)


# now let's write the layers in your directory
## this is to define the names of your layers
rnames <- paste0(names(masked), ".tif")

## this part will write the layers (this is similar to a loop, just a little fancier)
wr <- lapply(1:nlayers(masked), function(x) {
  writeRaster(masked[[x]], filename = rnames[x], format = "GTiff")
})

## check your directory now and see if layers were written

