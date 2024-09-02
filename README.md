##### Process NetCDF Data

```shell
export NETCDF_PATH=/tmp/data/netcdf-cams
```

```shell
docker build . -t cams-european-forecasts \
  --build-arg netcdf_path=$NETCDF_PATH \
  -f .docker/Dockerfile
```

```shell
docker run --rm -it -v /tmp/data:/tmp/data cams-european-forecasts
```
