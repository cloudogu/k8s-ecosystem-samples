MAKEFILES_VERSION=10.9.1

include build/make/variables.mk
include build/make/self-update.mk
include build/make/k8s.mk

.PHONY: update-versions
update-versions: $(BINARY_YQ)
	./scripts/update-versions.sh