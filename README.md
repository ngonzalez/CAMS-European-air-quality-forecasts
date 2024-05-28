##### Process NetCDF Data

```shell
export NETCDF_PATH=/mnt/data/netcdf
```

```shell
docker build . -t cams-european-forecasts \
  --build-arg netcdf_path=$NETCDF_PATH \
  -f .docker/Dockerfile
```

```shell
docker run --rm -it -v /data:/mnt/data -d cams-european-forecasts
```
