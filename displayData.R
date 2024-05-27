
# install.packages("ncdf4")
# install.packages("terra")

library(ncdf4)
library(terra)

setwd("/mnt/data/netcdf")

nc <- nc_open("ENS_ANALYSIS.nc")

time <- ncvar_get(nc, "time")

ndvi.array <- ncvar_get(nc, "nh3_conc")

nc_attributes <- ncatt_get(nc, "nh3_conc")

r <- try(terra::rast(ndvi.array, ))
r <- flip(r, direction="horizontal")

for (i in 1:length(time)) {
    terra::plot(rev(r)[[i:i]],
      col=grey(0:100/100, alpha=0.9),
      main=nc_attributes$species,
      maxcell=1000000
    )
}
