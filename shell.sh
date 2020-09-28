BASEDIR=$(readlink -f "$(dirname "$0")")
PWD=$(pwd)

echo "$@"

docker rm aipdocker
docker run -v "$PWD:$PWD" -w "$PWD" --name aipdocker -it aip:$(cat $(readlink -f VERSION)) "$@"