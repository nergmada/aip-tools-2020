#note that $(cat $(readlink -f VERSION)) is just a clever way to read the VERSION file
# You can hard code it instead
docker build --tag aip:$(cat $(readlink -f VERSION)) --file student.Dockerfile .