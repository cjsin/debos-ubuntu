include Makefile.common

.PHONY: builder build

all: builder build

builder:
	make -C $@ $@

osbuild:
	make -C $@ $@
