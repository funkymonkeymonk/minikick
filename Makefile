# Licensed under the MIT license:
# http://www.opensource.org/licenses/MIT-license
# Copyright (c) 2015, funkymonkeymonk <monkey@buildingbananas.com>

org_name := "buildingbananas"
project_name := "minikick"
project_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# lists all available targets
list:
	@sh -c "$(MAKE) -p no_targets__ | \
		awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);\
		for(i in A)print A[i]}' | \
		grep -v '__\$$' | \
		grep -v 'make\[1\]' | \
		grep -v 'Makefile' | \
		sort"
# required for list
no_targets__:

pull:
	@docker pull $(org_name)/$(project_name) && \
		echo docker pull successful || \
		echo docker pull unsuccessful

build: pull
	@docker build -t $(org_name)/$(project_name) .

run: build
	@docker run -it --rm \
		-h $(project_name) \
		--name $(project_name)_run \
		$(org_name)/$(project_name)

# test your application (tests in the tests/ directory)
test: build
	@docker run -it --rm \
		-h $(project_name) \
		$(org_name)/$(project_name) /bin/bash -c "rspec"

term: build
	@docker run -it --rm \
		-h $(project_name) \
		-v $(project_dir):/usr/src/app \
		-v $(HOME):/root \
		--name $(project_name)_term \
		$(org_name)/$(project_name) /bin/bash -i

deliver:
	@docker login -e="$(DOCKER_EMAIL)" \
								-u="$(DOCKER_USERNAME)" \
								-p="$(DOCKER_PASSWORD)"
	@docker push $(org_name)/$(project_name)

deploy:
	@echo "no deploy yet for $(project_name)"

docs:
	@cat README.md
