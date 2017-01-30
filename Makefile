tag := $(shell git describe --tags --abbrev=0)

finder:
	echo $(tag)
