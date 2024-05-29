packages <- c('ncdf4', 'terra')
install.packages(setdiff(packages, rownames(installed.packages())))

library(ncdf4)
library(terra)

if (length(commandArgs(trailingOnly=TRUE))>0) {
  args <- commandArgs(trailingOnly=TRUE)
  selected <- args[1]
} else {
  stop("NETCDF_PATH is missing", call.=FALSE)
}

setwd(Sys.getenv('NETCDF_PATH'))

fnames <- list.files(pattern = "*.nc$", all.files = FALSE)

for (file in fnames) {

  nc <- nc_open(file)

  # selected
  nc_vars <- names(nc$var)
  variable <- grep(selected, nc_vars, value=TRUE)

  # variables
  ndvi.array    <- ncvar_get(nc, variable)
  time          <- ncvar_get(nc, "time")

  # attributes
  nc_attributes <- ncatt_get(nc, variable)
  analysis      <- ncatt_get(nc, 0, "ANALYSIS")
  history       <- ncatt_get(nc, 0, "history")

  r <- try(terra::rast(ndvi.array, ))
  r <- flip(r, direction="horizontal")

  filename <- paste(file, variable, ".pdf")
  pdf(file=filename)

  for (i in 1:length(time)) {
    terra::plot(rev(r)[[i:i]],
      main=nc_attributes$species,
      maxcell=1000000,
    )

    mtext(analysis$value, side = 4)
    mtext(paste(history$value, nc_attributes$units), side = 2)
  }

  dev.off()
}
