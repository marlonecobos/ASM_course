# r pacakges needed
# if need to install pacakges use: install.packages("package_name")
library(raster)


# set your working directory (where you have the polygons and base_layer)
setwd("Your/directory")


# groups of layers (this are examples only)
## names of groups, in this case I am assuming you have 3 groups of layers
groups <- c("g1", "g2", "g3")

## base layer (the one to make the other ones match)
### name of layer
raster_file <- "base_layer.tif"

### creating raster
raster_layer <- raster(raster_file) 


## group 1 (you know these variables coincide, place them in one folder)
### variable files
g1_vars <- list.files(path = "folder_group1", pattern = ".tif$", 
                      full.names = TRUE)

### creating stack
g1_raster <- stack(g1_vars) 


## group 2 (you know these variables coincide, place them in another folder)
### variable files
g2_vars <- list.files(path = "folder_group2", pattern = ".tif$", 
                      full.names = TRUE)

### creating stack
g2_raster <- stack(g2_vars) 


## group 3 (you know these variables coincide, place them in another folder)
### variable files
g3_vars <- list.files(path = "folder_group3", pattern = ".tif$", 
                      full.names = TRUE)

### creating stack
g3_raster <- stack(g3_vars) 


# check resolution, extent, and dimensions
## resolution
base_res <- res(raster_layer)
g1_res <- res(g1_raster)
g2_res <- res(g2_raster)
g3_res <- res(g3_raster)

### get the ones with different resolution
wd_res <- which(c(g1_res, g2_res, g3_res) != base_res)

dif_res <- groups[wd_res]

print(dif_res)


## dimensions
base_dim <- dim(raster_layer)[1:2]
g1_dim <- dim(g1_raster)[1:2]
g2_dim <- dim(g2_raster)[1:2]
g3_dim <- dim(g3_raster)[1:2]

### get the ones with different dimensions
wd_dim <- which(c(g1_dim, g2_dim, g3_dim) != base_dim)

dif_dim <- groups[wd_dim]

print(dif_dim)


## extent
base_ext <- extent(raster_layer)
g1_ext <- extent(g1_raster)
g2_ext <- extent(g2_raster)
g3_ext <- extent(g3_raster)

### get the ones with different extent
wd_ext <- which(c(g1_ext, g2_ext, g3_ext) != base_ext)

dif_ext <- groups[wd_ext]

print(dif_ext)