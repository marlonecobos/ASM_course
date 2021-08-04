# r packages needed
# if you need to install the packages use install.packages("package_name")
library(raster)

# defined your directory
setwd("YOUR/DIRECTORY")

# listing the files you want to mask (place them in subfolder so it is easier to
# find them) in my case the folder is "test_folder" (change it accordingly)
list_files <- list.files(path = "test_folder", pattern = ".tif$",
                         full.names = TRUE)

# now lets create a stack of all raster layers
list_rasters <- stack(list_files)

# names of layers to write them afterwards
rnames <- paste0(names(list_rasters), ".tif")

# mask layer using one from the stack
msk <- list_rasters[[1]]

# recognizing NA values in all layers by summing
msk[] <- rowSums(list_rasters[])

# replacing no NA values with 1 so we can mask by multiplying
msk[!is.na(msk[])] <- 1

# masking all layers by multiplying by mask
list_rasters <- list_rasters * msk

# save the files in a new folder
new_folder <- "masked_MODIS"
dir.create(new_folder)

# write raster layers in new folder
rnames <- paste0(new_folder, "/", rnames) # new names including path

wr <- lapply(1:nlayers(list_rasters), function(x) {
  writeRaster(list_rasters[[x]], filename = rnames[x], format = "GTiff")
})


# now the PCA
# it requires the pacakge kuenm (install it if needed)
# before installing the package make sure you have compiling tools
# please follow the instructions in the "kuenm_practice" guide you can find at
# https://github.com/marlonecobos/ASM_course#asm-course

# install needed packages (this one helps to install the next one)
install.packages("remotes")

# install kuenm
remotes::install_github("marlonecobos/kuenm")

# loading needed package
library(kuenm)

## preparing function's arguments
var_folder <- new_folder # name of folder with variables to be used
in_format <- "GTiff" # other options available are "ascii" and "EHdr" = bil
scalev <- TRUE # scale variables
writer <- TRUE # save results
out_format <- "GTiff" # other options available are "ascii" and "EHdr" = bil
out_folder <- "PCA_results" # name of folder that will contain the sets
n_pcs <- 6 # number of pcs you want as rasters, if not defined all pcs are returned as rasters


## runing PCA
kuenm_rpca(variables = var_folder, in.format = in_format, var.scale = scalev,
           write.result = writer, out.format = out_format, out.dir = out_folder,
           n.pcs = n_pcs)
