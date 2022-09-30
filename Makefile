UNAME_OS                     := $(shell uname -s)
UNAME_OS_LOWER               := $(shell uname -s | tr '[:upper:]' '[:lower:]')
# uname reports x86_64. rename to amd64 to make it usable by goreleaser
UNAME_ARCH                   := $(shell uname -m | sed "s/x86_64/amd64/g")

# Macos is using universal binaries
ifeq ($(UNAME_OS_LOWER),darwin)
	UNAME_ARCH := all
endif

AKASH_VERSION_FILE               := $(CACHE_VERSIONS)/akash/$(AKASH_VERSION)
PROVIDER_SERVICES_VERSION_FILE   := $(CACHE_VERSIONS)/provider-services/$(PROVIDER_SERVICES_VERSION)

cache_init                       := $(CACHE_DIR)/.init
test_key                         := $(AKASH_HOME)/keyring-test/test.info

.PHONY: cache
cache: $(cache_init)

.PHONY: init
init: $(cache_init) $(AKASH) $(PROVIDER_SERVICES)

.PRECIOUS: %/.init
%/.init:
	@echo "creating dir structure..."
	mkdir -p ${@D}
	mkdir -p $(CACHE_BIN)
	mkdir -p $(CACHE_VERSIONS)
	touch $@

$(AKASH_VERSION_FILE): $(cache_init)
	@echo "Installing akash $(AKASH_VERSION) ..."
	rm -f $(AKASH)
	wget -q https://github.com/ovrclk/akash/releases/download/v$(AKASH_VERSION)/akash_$(UNAME_OS_LOWER)_$(UNAME_ARCH).zip -O $(CACHE_DIR)/akash.zip
	unzip -p $(CACHE_DIR)/akash.zip akash_$(UNAME_OS_LOWER)_$(UNAME_ARCH)/akash > $(AKASH)
	chmod +x $(AKASH)
	rm $(CACHE_DIR)/akash.zip
	rm -rf "$(dir $@)"
	mkdir -p "$(dir $@)"
	touch $@
$(AKASH): $(AKASH_VERSION_FILE)

$(PROVIDER_SERVICES_VERSION_FILE): $(cache_init)
	@echo "Installing provider-services $(PROVIDER_SERVICES_VERSION) ..."
	rm -f $(PROVIDER_SERVICES)
	wget -q https://github.com/ovrclk/provider-services/releases/download/v$(PROVIDER_SERVICES_VERSION)/provider-services_$(UNAME_OS_LOWER)_$(UNAME_ARCH).zip \
		-O $(CACHE_DIR)/provider-services.zip
	unzip -p $(CACHE_DIR)/provider-services.zip provider-services_$(UNAME_OS_LOWER)_$(UNAME_ARCH)/provider-services > $(PROVIDER_SERVICES)
	chmod +x $(PROVIDER_SERVICES)
	rm $(CACHE_DIR)/provider-services.zip
	rm -rf "$(dir $@)"
	mkdir -p "$(dir $@)"
	touch $@
$(PROVIDER_SERVICES): $(PROVIDER_SERVICES_VERSION_FILE)

$(test_key):
	$(AKASH) keys add test

.PHONY: clean
clean:
	rm -rf $(CACHE_DIR)
