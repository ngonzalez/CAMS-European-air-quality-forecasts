
install.packages("ncdf4")
install.packages("terra")

library(ncdf4)
library(terra)

setwd("/mnt/data/netcdf")

nc <- nc_open("ENS_ANALYSIS.nc")

ndvi.array <- ncvar_get(nc, "nh3_conc")

nc_attributes <- ncatt_get(nc, "nh3_conc")

r <- try(terra::rast(ndvi.array, ))
r <- flip(r, direction="horizontal")

if(!inherits(r, "try-error")) {
  terra::plot(rev(r)[[1:6]], main = nc_attributes$species) +
    coord_quickmap(xlim=c(latlon[3], latlon[4]), ylim=c(latlon[1], latlon[2]))

}
