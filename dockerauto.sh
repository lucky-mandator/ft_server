#!/bin/bash

docker build -t im .
open https://localhost
docker run --name server -it -p 80:80 -p 443:443 im
