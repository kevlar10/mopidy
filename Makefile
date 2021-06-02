DATE := $(shell date +"%Y-%m-%d")

build-pc:
	docker build --pull -t kevlar10/mopidy:$(DATE) --build-arg BUILD_FROM=debian:stable-slim .

build-pi:
	docker build --pull -t kevlar10/mopidy:$(DATE) --build-arg BUILD_FROM=balenalib/rpi-raspbian:latest .

tag:
	docker tag kevlar10/mopidy:$(DATE) kevlar10/mopidy:latest
