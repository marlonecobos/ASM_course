# Function to calculate geographic distances and return a raster of results

# spatial_object : spatial object from which distances to every point in
#                  (raster_base) will be measured.
# raster_base    : RasterLayer to use a base for calculations.
# split_spatial  : whether to split spatial objects and perform calculations by
#                  feature. Default = FALSE. Use it when complex spatial objects
#                  are used.



gdist_spatiat_raster <- function(spatial_object, raster_base,
                                 split_spatial = FALSE) {
  ## detecting what is no data in layer
  no_nas_r <- which(!is.na(raster_base[]))

  # calculations
  ## turning raster into points
  points_r <- as(raster_base,"SpatialPoints")

  ## re-projecting for distance calculation
  crsed <- rangemap::AED_projection(points_r@coords)

  points_r <- sp::spTransform(points_r, crsed)
  spatial_object <- sp::spTransform(spatial_object, crsed)

  ## calculating distance to all raster points
  if (split_spatial == TRUE) {
    dists_p <- lapply(1:nrow(spatial_object), function(x) {
      rgeos::gDistance(points_r, spatial_object[x, ], byid = TRUE)
    })
    dists_p <- do.call(rbind, dists_p)
  } else {
    dists_p <- rgeos::gDistance(points_r, spatial_object, byid = TRUE)
  }

  ## getting minimum distances per point in the raster
  dist_min <- apply(dists_p, 2, min)

  # preparing distance layer
  base_r[no_nas_r] <- dist_min

  return(base_r)
}
