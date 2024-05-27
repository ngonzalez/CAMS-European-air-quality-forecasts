packages <- c('ncdf4', 'terra')
install.packages(setdiff(packages, rownames(installed.packages())))

t1 <- Sys.time()

if (length(commandArgs(trailingOnly=TRUE))>0) {
  args <- commandArgs(trailingOnly=TRUE)
}

library(ncdf4)
library(terra)

setwd("/mnt/data/netcdf")

nc <- nc_open("ENS_ANALYSIS.nc")

selected <- args[1]

nc_vars <- names(nc$var)

variable <- grep(selected, nc_vars, value=TRUE)

ndvi.array <- ncvar_get(nc, variable)

time <- ncvar_get(nc, "time")

nc_attributes <- ncatt_get(nc, variable)

r <- try(terra::rast(ndvi.array, ))
r <- flip(r, direction="horizontal")

for (i in 1:length(time)) {
    terra::plot(rev(r)[[i:i]],
      col=grey(0:100/100, alpha=0.9),
      main=nc_attributes$species,
      maxcell=1000000
    )
}

print(difftime(Sys.time(), t1, units = "seconds"))
