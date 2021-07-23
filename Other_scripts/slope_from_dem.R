# r package needed, to install it use this line
# install.packages("raster")

library(raster)


# reading DEM layer
## layer name (include path if needed) 
dem_name <- "C:/Users/m538c005/Downloads/IndiaMerged_GMTED_med075.tif"

## reading layer
dem <- raster(dem_name)

# slope calculation
area_slope <- terrain(dem, opt = 'slope', unit = 'degrees')

# write slope
## file name
slope_name <- "C:/Users/m538c005/Downloads/slope_India.tif"

## writing file in tif format
writeRaster(area_slope, filename = slope_name, format = "GTiff")
