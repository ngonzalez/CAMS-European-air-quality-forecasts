##### Process NetCDF Data

```shell
export NETCDF_PATH=/tmp/data/netcdf
```

```shell
docker build . -t cams-european-forecasts \
  --build-arg netcdf_path=$NETCDF_PATH \
  -f .docker/Dockerfile
```

```shell
docker run --rm -it -v /tmp/data:/tmp/data cams-european-forecasts
```

Data available at Wekeo.eu:

[CAMS_EUROPE_AIR_QUALITY_FORECASTS](https://www.wekeo.eu/data?view=dataset&dataset=EO%3AECMWF%3ADAT%3ACAMS_EUROPE_AIR_QUALITY_FORECASTS)
