packages <- c('ncdf4', 'terra')
install.packages(setdiff(packages, rownames(installed.packages())))

if (length(commandArgs(trailingOnly=TRUE))>0) {
  args <- commandArgs(trailingOnly=TRUE)
  selected <- args[1]
} else {
  stop("NETCDF_PATH is missing", call.=FALSE)
}

library(ncdf4)
library(terra)

setwd(Sys.getenv('NETCDF_PATH'))

filenames <- list.files(path=".", pattern="\\.nc$", full.names=TRUE)

for (index in 1:length(filenames))

  nc <- nc_open(filenames[index])

  nc_vars <- names(nc$var)

  variable <- grep(selected, nc_vars, value=TRUE)

  ndvi.array <- ncvar_get(nc, variable)

  time <- ncvar_get(nc, "time")

  nc_attributes <- ncatt_get(nc, variable)

  r <- try(terra::rast(ndvi.array, ))
  r <- flip(r, direction="horizontal")

  filename <- paste(filenames[index], variable, ".pdf")
  pdf(file=filename)

  for (i in 1:length(time)) {
    terra::plot(rev(r)[[i:i]],
      main=nc_attributes$species,
      maxcell=1000000,
    )
    dev.off()
  }
