#note that $(cat $(readlink -f VERSION)) is just a clever way to read the VERSION file
# You can hard code it instead

docker run --name aipdocker -it aip:$(cat $(readlink -f VERSION))