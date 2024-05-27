##### Start rstudio from Docker image

Login with rstudio/admin

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

Install dependencies from rstudio terminal:

```shell
sudo apt-get install gdal-bin libgdal-dev proj-bin
```
