SHELL = /bin/sh

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# --- Git Hooks ------------------------------------------------------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

.PHONY: git-hooks-install
git-hooks-install:
	@# Install the latest version of Lefthook (a Git hooks manager) and set it up.
	command -v lefthook || go install github.com/evilmartians/lefthook@latest; lefthook install

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# --- Go (Golang) ----------------------------------------------------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

.PHONY: go-mod-clean
go-mod-clean:
	go clean -modcache

.PHONY: go-mod-tidy
go-mod-tidy:
	go mod tidy

.PHONY: go-mod-update
go-mod-update:
	@# Update test dependencies.
	go get -f -t -u ./...
	@# Update all other dependencies.
	go get -f -u ./...

.PHONY: go-generate
go-generate:
	go generate ./...

.PHONY: go-fmt
go-fmt:
	go fmt ./...

.PHONY: go-lint
go-lint: go-fmt
	golangci-lint run $(GOLANGCILINT) ./...

.PHONY: go-test
go-test:
	go test -v -race ./...

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# --- Help -----------------------------------------------------------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

.PHONY: help
help:
	@echo ""
	@echo "Available commands:"
	@echo ""
	@echo " Git Hooks:"
	@echo "  git-hooks-install ........ Install Git hooks."
	@echo ""
	@echo " Go (Golang):"
	@echo "  go-mod-clean ............. Clean Go module cache."
	@echo "  go-mod-tidy .............. Tidy Go modules."
	@echo "  go-mod-update ............ Update Go modules."
	@echo "  go-generate .............. Run Go generate."
	@echo "  go-fmt ................... Format Go code."
	@echo "  go-lint .................. Lint Go code."
	@echo "  go-test .................. Run Go tests."
	@echo ""
	@echo " Help:"
	@echo "  help ..................... Display this help information."
	@echo ""

.DEFAULT_GOAL = help