all: build

ARGS :=
PLATFORM := linux/arm64,linux/amd64

build: latest
	@echo "Building the container..."
	@docker buildx build $(ARGS) --platform $(PLATFORM) -t andreasfertig/cppinsights-webfrontend-container `pwd`
	@touch urls.db
	@echo "Done."
	@echo "You still required the C++ Insights container!"
	@echo "Use make start to start the container, make stop to stop it."

latest: clean
	@wget https://github.com/andreasfertig/cppinsights-web/archive/latest.zip

clean:
	@rm -f latest.zip

get:
	@echo "Pulling the latest 'andreasfertig/cppinsights-container'..."
	@docker pull andreasfertig/cppinsights-container
	@echo "Pulling the latest 'andreasfertig/cppinsights-webfrontend-container'..."
	@docker pull andreasfertig/cppinsights-webfrontend-container
	@touch urls.db
	@chmod 0666 urls.db
	@echo "You now can use 'make start' to fire up your local C++ Insights installation."

start:
	@docker start cppinsights-webfrontend-container 2>/dev/null || \
		docker run -p 127.0.0.1:5001:5000 -e DOCKER_DEFAULT_PLATFORM="${DOCKER_DEFAULT_PLATFORM}" -v /var/run/docker.sock:/var/run/docker.sock -v $(PWD)/urls.db:/urls.db --name=cppinsights-webfrontend-container -v /tmp:/tmp -d andreasfertig/cppinsights-webfrontend-container

stop:
	@docker stop cppinsights-webfrontend-container

logs:
	@docker logs -f cppinsights-webfrontend-container

purge:
	@docker stop cppinsights-webfrontend-container >/dev/null
	@docker rm -v cppinsights-webfrontend-container >/dev/null
