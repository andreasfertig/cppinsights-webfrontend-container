# C++ Insights: Web Front-End Docker Container

This is some what of a docker in docker setup.

You have to have this container which hosts the C++ Insights Web Frontend part and the container which contains the [C++
Insights binary](https://github.com/andreasfertig/cppinsights-container). Both installed on your local machine.

Then run `make get` to download the latest pre-built docker image from [DockerHub](https://hub.docker.com/r/andreasfertig/cppinsights-webfrontend-container) as well as the required [cppinsights-container](https://hub.docker.com/r/andreasfertig/cppinsights-container).

Alternatively you can build the image yourself, as Travis-CI does. Run `make build` to get all the resources and build the docker image of this repo. You have to take care of build
the image of the C++ Insights docker.

After either of these two steps, you can run `make start` to start the web part. Give it a few seconds to boot up. After that C++ Insights is
reachable under 127.0.0.1:5000.

You can see what is going on with `make logs` and stop the container with `make stop`

## How does it work?

The setup is based in [this blog post](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/). The
docker container of this repo gets the docker socket of your local machine as well as the `/tmp` folder mapped into the
running container. With that it can access the image on you local machine (which should contain the cppinsights-container)

