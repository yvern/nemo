LINUX ?= alpine
.PHONY: build test clean

nemo.so:
	docker run -v `pwd`:/usr/src/app \
		-w /usr/src/app \
		nimlang/nim:$(LINUX) nimble bld

build: nemo.so

test: nemo.so
	docker run -v `pwd`:/usr/src/app \
		-w /usr/src/app \
		nimlang/nim:$(LINUX) python nemo.py

csources:
	docker run -v `pwd`:/usr/src/app \
		-w /usr/src/app \
		nimlang/nim:$(LINUX) nimble src

clean:
	- rm nemo.so
	- rm -r csources
