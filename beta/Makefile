all: clean Packages Packages.bz2

Packages:
	dpkg-scanpackages -m ./debs > Packages

Packages.bz2: Packages
	bzip2 -fk Packages

clean: 
	rm -f Packages Packages.bz2