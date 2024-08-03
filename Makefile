include .env	

IMAGE = ${LOCATION}-${REGISTRY}/${PROJECT_ID}/${REPOSITORY}/${ARTIFACT}:${VERSION}-${TARGETOS}-${TARGETARCH}-${ENVIRONMENT}

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
	docker build -t ${IMAGE} .

dive: image
	IMG1=$$(docker images -q | head -n 1); \
	CI=true docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive \
	--ci \
	--highestWastedBytes=1MB \
	--highestUserWastedPercent=0.05 \
	--lowestEfficiency=0.98 \
	$${IMG1}; \
	docker rmi $${IMG1}

run:
	docker run -p 8080:8080 --name=${ARTIFACT} ${IMAGE}

push:
	docker push ${IMAGE}

clean:
	docker rmi ${IMAGE}