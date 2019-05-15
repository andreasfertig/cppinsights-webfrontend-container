all: build

build: #insights
	@echo "Building the container..."
	@docker build -t cppinsights-webfrontend `pwd`
	@echo "Done."
	@echo "You still required to C++ Insights container!"
	@echo "Use make start to start the container, make stop to stop it."

start:
	@docker run --rm -p 127.0.0.1:5000:5000 -v /var/run/docker.sock:/var/run/docker.sock --name=cppinsights-webfrontend -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/tmp -d cppinsights-webfrontend

stop:
	@docker stop cppinsights-webfrontend

logs:
	@docker logs -f cppinsights-webfrontend

insights: clean
	wget https://github.com/andreasfertig/cppinsights-web/archive/master.zip

clean:
	rm -f master.zip* insights
