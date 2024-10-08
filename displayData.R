packages <- c('ncdf4', 'terra')
install.packages(setdiff(packages, rownames(installed.packages())))

library(ncdf4)
library(terra)

if (length(commandArgs(trailingOnly=TRUE))>0) {
  args <- commandArgs(trailingOnly=TRUE)
  selected <- args[1]
} else {
  stop("Missing selected variable argument", call.=FALSE)
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
  analysis      <- ncatt_get(nc, 0, "FORECAST")
  history       <- ncatt_get(nc, 0, "history")
  time_long     <- ncatt_get(nc, "time", "long_name")

  r <- try(terra::rast(ndvi.array, ))
  r <- flip(r, direction="horizontal")

  filename <- paste(file, variable, ".pdf")
  pdf(file=filename)

  for (i in 1:length(time)) {
    terra::plot(r[[i:i]],
      maxcell=1000000,
    )

    # [1] "Carbon Monoxide µg/m3"
    mtext(paste(nc_attributes$species, nc_attributes$units),
      side = 3, line=3.2, cex=0.9)

    # [1] "Model ENSEMBLE FORECAST 2024-09-01"
    d <- strsplit(time_long$value, split=" ")[[1:1]][4]
    mtext(paste(history$value, as.Date(d, "%Y%m%d") + i),
      side = 3, line=2.7, cex=0.7)
  }

  dev.off()
}
