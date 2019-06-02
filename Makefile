SHELL = /bin/bash
BUILD_DIR = ./build

all: clean gh-pages

clean:
	rm -rf repo repo-beta $(BUILD_DIR)

repo repo-beta:
	rm -rf $@
	mkdir -p ./$@/debs/
	cp ./debs/* ./$@/debs/ || :
	@if [ $@ == "repo-beta" ]; then cp ./debs-beta/* ./$@/debs/ || :; fi
	cd $@; dpkg-scanpackages -m ./debs/ > Packages
	bzip2 -fk $@/Packages
	gzip -fk $@/Packages

build-repo: repo
	mkdir -p $(BUILD_DIR)
	cp -r CydiaIcon.png Release ./repo/* $(BUILD_DIR)

build-repo-beta: repo-beta
	mkdir -p $(BUILD_DIR)/beta/
	cp CydiaIcon-beta.png $(BUILD_DIR)/beta/CydiaIcon.png
	cp Release-beta $(BUILD_DIR)/beta/Release
	cp -r ./repo-beta/* $(BUILD_DIR)/beta/

gh-pages: build-repo build-repo-beta
	cp -r assets CNAME _config.yml index.html $(BUILD_DIR)

.PHONY: clean repo repo-beta

