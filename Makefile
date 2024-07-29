REGISTRY=gcr.io/dev8ops/kbot

# variables moved from .env file for hotfix/prometheus.org_test-3.5.5
TARGETOS=linux # linux darwin windows
TARGETARCH=amd64 # amd64 arm64

VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
PKGS=$(shell go list ./... | fgrep -v /vendor)
# end of moved variables

get:
	go get

lint:
	go vet ${PKGS}

format:
	gofmt -s -w ./

test:
	go test -v

build: get format
	CGO_ENABLED=0 GOOS=${TARGETOS} \
	GOARCH=${TARGETARCH} \
	go build -v -o kbot -ldflags "-X="github.com/artur-titov/kbot/cmd.appVersion=${VERSION}

image-test: lint format
	docker build --check .

image:
	docker build -t ${REGISTRY}:${VERSION}-${TARGETARCH} .

dive: image
	IMG1=$$(docker images -q | head -n 1); \
	CI=true docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive \
	--ci \
	--highestWastedBytes=1MB \
	--highestUserWastedPercent=0.05 \
	--lowestEfficiency=0.98 \
	$${IMG1}; \
	IMG2=$$(docker images -q | sed -n 2p); \
	docker rmi $${IMG1}; \
	docker rmi $${IMG2}

push:
	docker push ${REGISTRY}:${VERSION}-${TARGETARCH}

clean:
	docker rmi ${REGISTRY}:${VERSION}-${TARGETARCH}