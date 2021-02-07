SHELL:=/bin/bash
.ONESHELL:

all: dep test

dep:
	go get ./...

test:
	for dir in tests/*; do \
		echo "Running tests in: " $$dir
		sh $$dir/runTests.sh
	done; \

.PHONY: dep test