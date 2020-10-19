set /p version=< VERSION
docker build --tag aip:%version% --file student.Dockerfile .