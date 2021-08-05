# r pacakges needed
# if need to install pacakges use: install.packages("package_name")
library(raster)


# set your working directory (where you have the polygons and base_layer)
setwd("Your/directory")


# groups of layers (this are examples only)
## names of groups, in this case I am assuming you have 6 groups of layers
groups <- paste0("g", 1:6)

## base layer (the one to make the other ones match)
### name of layer
raster_file <- "CHELSApc_1.asc"

### creating raster
raster_layer <- raster(raster_file)


## group 1
### variable files
g1_vars <- list.files(path = ".", pattern = "^livestock pc",
                      full.names = TRUE)

### creating stack
g1_raster <- stack(g1_vars)


## group 2
### variable files
g2_vars <- list.files(path = ".", pattern = "^MODISpc",
                      full.names = TRUE)

### creating stack
g2_raster <- stack(g2_vars)


## group 3
### variable files
g3_vars <- list.files(path = ".", pattern = "^WR",
                      full.names = TRUE)

### creating stack
g3_raster <- stack(g3_vars)


## group 4
### variable files
g4_vars <- list.files(path = ".", pattern = "^CHELSApc",
                      full.names = TRUE)

### creating stack
g4_raster <- stack(g4_vars)


## group 5
### creating raster
g5_raster <- raster("GMTEDpc_1.asc")


## group 6
### creating raster
g6_raster <- raster("slopepc_1.asc")



# check resolution, extent, and dimensions
## resolution
base_res <- res(raster_layer)[1]
g1_res <- res(g1_raster)[1]
g2_res <- res(g2_raster)[1]
g3_res <- res(g3_raster)[1]
g4_res <- res(g4_raster)[1]
g5_res <- res(g5_raster)[1]
g6_res <- res(g6_raster)[1]

### get the ones with different resolution
wd_res <- which(c(g1_res, g2_res, g3_res, g4_res, g5_res, g6_res) != base_res)

dif_res <- groups[wd_res]

print(dif_res)


## dimensions
base_dim <- dim(raster_layer)[1:2]
g1_dim <- dim(g1_raster)[1:2]
g2_dim <- dim(g2_raster)[1:2]
g3_dim <- dim(g3_raster)[1:2]
g4_dim <- dim(g4_raster)[1:2]
g5_dim <- dim(g5_raster)[1:2]
g6_dim <- dim(g6_raster)[1:2]

### get the ones with different dimensions
wd_dim1 <- which(c(g1_dim[1], g2_dim[1], g3_dim[1], g4_dim[1], g5_dim[1],
                   g6_dim[1]) != base_dim[1])

dif_dim1 <- groups[wd_dim1]
print(dif_dim1)

wd_dim2 <- which(c(g1_dim[2], g2_dim[2], g3_dim[2], g4_dim[2], g5_dim[2],
                   g6_dim[2]) != base_dim[2])

dif_dim2 <- groups[wd_dim2]
print(dif_dim2)


## extent
base_ext <- extent(raster_layer)
g1_ext <- extent(g1_raster)
g2_ext <- extent(g2_raster)
g3_ext <- extent(g3_raster)
g4_ext <- extent(g4_raster)
g5_ext <- extent(g5_raster)
g6_ext <- extent(g6_raster)


### get the ones with different extent
l_ext <- list(g1_ext, g2_ext, g3_ext, g4_ext, g5_ext, g6_ext)

dif_ext <- sapply(1:length(l_ext), function(x) {
  con <- l_ext[[x]] == base_ext

  ifelse(!con, groups[x], "")
})

print(dif_ext)



# lets try to fix this small problems using the a layer as a base
# resampling method (bilinear)
## g1
resa_g1 <- resample(g1_raster, raster_layer)

res(resa_g1)[1] == base_res
extent(resa_g1) == base_ext
dim(resa_g1)[1] == base_dim[1]
dim(resa_g1)[2] == base_dim[2]


## g3
resa_g3 <- resample(g3_raster, raster_layer)

res(resa_g3)[1] == base_res
extent(resa_g3) == base_ext
dim(resa_g3)[1] == base_dim[1]
dim(resa_g3)[2] == base_dim[2]

## g5
resa_g5 <- resample(g5_raster, raster_layer)

res(resa_g5)[1] == base_res
extent(resa_g5) == base_ext
dim(resa_g5)[1] == base_dim[1]
dim(resa_g5)[2] == base_dim[2]

## g6
resa_g6 <- resample(g6_raster, raster_layer)

res(resa_g6)[1] == base_res
extent(resa_g6) == base_ext
dim(resa_g6)[1] == base_dim[1]
dim(resa_g6)[2] == base_dim[2]


# writing back layers
## new directory
dir.create("Fixed_layers")

# g1
rnames <- paste0("Fixed_layers/", names(resa_g1), ".asc")

wr <- lapply(1:nlayers(resa_g1), function(x) {
  writeRaster(resa_g1[[x]], filename = rnames[x], format = "ascii")
})

# g2
rnames <- paste0("Fixed_layers/", names(g2_raster), ".asc")

wr <- lapply(1:nlayers(g2_raster), function(x) {
  writeRaster(g2_raster[[x]], filename = rnames[x], format = "ascii")
})

# g3
rnames <- paste0("Fixed_layers/", names(resa_g3), ".asc")

wr <- lapply(1:nlayers(resa_g3), function(x) {
  writeRaster(resa_g3[[x]], filename = rnames[x], format = "ascii")
})

# g4
rnames <- paste0("Fixed_layers/", names(g4_raster), ".asc")

wr <- lapply(1:nlayers(g4_raster), function(x) {
  writeRaster(g4_raster[[x]], filename = rnames[x], format = "ascii")
})

# g5
rnames <- paste0("Fixed_layers/", names(resa_g5), ".asc")

wr <- lapply(1:nlayers(resa_g5), function(x) {
  writeRaster(resa_g5[[x]], filename = rnames[x], format = "ascii")
})

# g6
rnames <- paste0("Fixed_layers/", names(resa_g6), ".asc")

wr <- lapply(1:nlayers(resa_g6), function(x) {
  writeRaster(resa_g6[[x]], filename = rnames[x], format = "ascii")
})
