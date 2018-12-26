all: clean Packages Packages.bz2 Packages.gz

update: all
	git add debs/ Packages Packages.bz2 Packages.gz
	git commit -m "Repo Package Update"
	git push

beta:
	make -C beta/

Packages:
	dpkg-scanpackages -m ./debs > Packages

Packages.bz2: Packages
	bzip2 -fk Packages

Packages.gz: Packages
	gzip -fk Packages

clean: 
	rm -f Packages Packages.bz2 Packages.gz

.PHONY: clean beta