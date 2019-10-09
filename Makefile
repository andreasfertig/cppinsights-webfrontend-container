all: build

build: latest
	@echo "Building the container..."
	@docker build -t cppinsights-webfrontend-container `pwd`
	@touch urls.db
	@echo "Done."
	@echo "You still required the C++ Insights container!"
	@echo "Use make start to start the container, make stop to stop it."

latest: clean
	@wget https://github.com/andreasfertig/cppinsights-web/archive/latest.zip

clean:
	@rm -f latest.zip

get:
	@make stop
	@echo "Pulling the latest 'andreasfertig/cppinsights-container'..."
	@docker pull andreasfertig/cppinsights-container
	@echo "Pulling the latest 'andreasfertig/cppinsights-webfrontend-container'..."
	@docker pull andreasfertig/cppinsights-webfrontend-container
	@touch urls.db
	@chmod 0666 urls.db
	@echo "You now can use 'make start' to fire up your local C++ Insights installation."

start:
	@docker run --rm -p 127.0.0.1:5000:5000 -v /var/run/docker.sock:/var/run/docker.sock -v $(PWD)/urls.db:/urls.db --name=cppinsights-webfrontend-container -v /tmp:/tmp -d andreasfertig/cppinsights-webfrontend-container

stop:
	@docker stop andreasfertig/cppinsights-webfrontend-container

logs:
	@docker logs -f andreasfertig/cppinsights-webfrontend-container

