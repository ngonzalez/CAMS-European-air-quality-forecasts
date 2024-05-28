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

##### Start rstudio from Docker image

```shell
docker run --rm -ti \
 -v .:/home/rstudio \
 -v $HOME/.config/rstudio:/home/rstudio/.config/rstudio \
 -v $HOME/.Renviron:/home/rstudio/.Renviron \
 -v /data:/mnt/data \
 -e PASSWORD=admin \
 -e ROOT=TRUE \
 -p 8787:8787 rocker/rstudio
```
