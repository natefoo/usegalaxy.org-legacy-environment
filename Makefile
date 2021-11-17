BUILD 			= 0
DOCKER_IMAGE		= usegalaxy.org-legacy-environment:$(BUILD)
DOCKER_IMAGE_TARBALL	= docker-usegalaxy.org-legacy-environment--$(BUILD).tar.gz
SINGULARITY_IMAGE	= usegalaxy.org-legacy-environment--$(BUILD)
DEPLOY			= g2main@galaxy04.tacc.utexas.edu:/corral4/main/singularity

usegalaxy.org-legacy-environment--$(BUILD):
	[ -z $(docker images -q "$@") ] || docker rmi "$(DOCKER_IMAGE)"
	docker build -t "$(DOCKER_IMAGE)" docker
	docker save "$(DOCKER_IMAGE)" -o "$(DOCKER_IMAGE_TARBALL)"
	singularity build "$(SINGULARITY_IMAGE)" "docker-archive://$(DOCKER_IMAGE_TARBALL)"

deploy:
	rsync -avP "$(SINGULARITY_IMAGE)" "$(DEPLOY)"

.PHONY: deploy
