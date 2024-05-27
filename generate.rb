require 'pry'
require 'carray'
require 'carray-netcdf'

include NC

FILENAME = "/data/netcdf/ENS_ANALYSIS.nc"

nc = NCFile.open(FILENAME)

fd = nc_open(FILENAME)

varid = nc_inq_varid(fd, 'co_conc')

data = nc.vars[varid]

printf data.to_ca.inspect

exit 0
