
include ../Makefile.common

gosrc			=	$(shell echo ~/go/src)
export GOBIN	=	$(shell echo ~/go/bin)
DEBOS_SOURCES	=	$(shell find $(gosrc)/github.com/go-debos/ -name "*.go")
BUILDER_SOURCES		=	Dockerfile \
						entrypoint.sh \
						debos


.PHONY: all builder

all: builder

gobuild: debos

#gobuild:
#	$(CONTAINER_RUN) --rm -v $(CURDIR):/workspace --workdir /workspace $(IMAGE):$(TAG) \
#		bash -c /workspace/gobuild.sh

builder: .builder.timestamp

.builder.timestamp: $(BUILDER_SOURCES)
	buildah bud \
		--layers=true \
		-f Dockerfile \
		--build-arg SUITE=$(SUITE) \
		--build-arg KVER=$(KVER) \
		--label LABEL=$(IMAGE):$(TAG) \
		-t $(IMAGE):$(TAG) \
		.
	touch $@

debos: $(DEBOS_SOURCES)
	@# Note for this go build to work, GOBIN must be set, GOPATH must be unset and the 'go install' must be run from in the go/src folder)
	@echo "$(GOROOT) [$(GOPATH), $(GOBIN)]"
	(cd ~/go/src && go install github.com/go-debos/debos/cmd/debos/debos.go)
	cp "$(GOBIN)/debos" $@
