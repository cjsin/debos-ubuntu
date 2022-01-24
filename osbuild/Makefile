include					../Makefile.common

RECIPE				=	debos.yaml

BUILD_SOURCES		=	$(RECIPE) \
						$(shell find scripts overlays -type f)

# Output artifacts
OUTPUT				=	output
ARTIFACTDIR			=	/artifacts
RECIPEDIR			=	/recipe
BUILD_OPTS_DOCKER	=	--user $(shell id -u) \
						--device /dev/kvm:/dev/kvm:rwm \
						--security-opt label=disable \
						--workdir $(RECIPEDIR) \
						-v $(CURDIR):$(RECIPEDIR) \
						-v $(CURDIR)/$(OUTPUT):$(ARTIFACTDIR):rw

DEBOOT_CACHE		=	ubuntu-$(SUITE)-$(ARCHITECTURE).deboot.tar.$(COMPRESSION)
USE_DEBOOT_CACHE	=	$(shell test -f $(OUTPUT)/$(DEBOOT_CACHE) && echo true || echo false)
SAVE_DEBOOT_CACHE	=	$(shell test -f $(OUTPUT)/$(DEBOOT_CACHE) && echo false || echo true)

BUILD_OPTS_DEBOS	=	--debug-shell \
						--verbose \
						--print-recipe \
						--show-boot \
						--artifactdir=$(ARTIFACTDIR) \
						-t distro:$(DISTRO) \
						-t architecture:$(ARCHITECTURE) \
						-t suite:$(SUITE) \
						-t compression:$(COMPRESSION) \
						-t use_deboot_cache:$(USE_DEBOOT_CACHE) \
						-t deboot_cache:$(DEBOOT_CACHE) \
						-t save_deboot_cache:$(SAVE_DEBOOT_CACHE) \
						-t mirror:$(MIRROR) \
						-t keyring:$(KEYRING)

.PHONY: osbuild enter
all: osbuild

printvars:
	@printf "%30s : %s\n" artifactdir $(ARTIFACTDIR)
	@printf "%30s : %s\n" architecture $(ARCHITECTURE)
	@printf "%30s : %s\n" distro $(DISTRO)
	@printf "%30s : %s\n" suite $(SUITE)
	@printf "%30s : %s\n" mirror $(MIRROR)
	@printf "%30s : %s\n" keyring $(KEYRING)
	@printf "%30s : %s\n" compression $(COMPRESSION)
	@printf "%30s : %s\n" deboot_cache $(DEBOOT_CACHE)
	@printf "%30s : %s\n" use_deboot_cache $(USE_DEBOOT_CACHE)
	@printf "%30s : %s\n" save_deboot_cache $(SAVE_DEBOOT_CACHE)

osbuild: ../builder/.builder.timestamp $(BUILD_SOURCES) printvars
	mkdir -p $(OUTPUT)
	$(CONTAINER_RUN) --rm -it $(BUILD_OPTS_DOCKER) $(IMAGE):$(TAG) \
		$(BUILD_OPTS_DEBOS) $(RECIPE); echo "[debos exit code $$?]"

enter: ../builder/.builder.timestamp $(RECIPE)
	mkdir -p $(OUTPUT)
	$(CONTAINER_RUN) --rm -it $(BUILD_OPTS_DOCKER) $(IMAGE):$(TAG) bash

