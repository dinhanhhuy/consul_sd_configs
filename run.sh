docker build . -t ubuntu-box
docker run --name ubuntu-box --rm -it -p 9090:9090 -p 9001:9001 -p 8500:8500 ubuntu-box bash