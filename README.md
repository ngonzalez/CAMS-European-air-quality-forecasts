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

```shell
sudo apt-get install gdal-bin libgdal-dev proj-bin
```

```r
Rscript displayData.R <variable>
```
