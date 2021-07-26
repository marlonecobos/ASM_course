# this script requires the pacakge kuenm
# before installing the package make sure you have compiling tools
# please follow the instructions in the "kuenm_practice" guide you can find at
# https://github.com/marlonecobos/ASM_course#asm-course


# now install needed packages (this one helps to install the next one)
install.packages("remotes")

# install kuenm
remotes::install_github("marlonecobos/kuenm")

# loading needed package
library(kuenm)


# defining working directory
setwd("Your/directory") # change this to your working directory

# place all your variables in a folder


##################
# simple raster PCA
## functions help (this will give you more details)
help(kuenm_rpca)

## preparing function's arguments
var_folder <- "folder_with_layers" # name of folder with variables to be used
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
