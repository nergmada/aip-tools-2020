docker rm aipdocker
set /p version=< VERSION
docker run --name aipdocker -it aip:%version%