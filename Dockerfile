FROM alpine:latest

ENV KUBECTL_VERSION=v1.10.8

RUN mkdir -p /app
WORKDIR /app
RUN apk -Uuv add curl ca-certificates bash
RUN apk --purge -v del py-pip && \
    update-ca-certificates && \
	rm /var/cache/apk/*
RUN wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && chmod +x ./kubectl

ADD run.sh /app/run.sh

ENTRYPOINT ["/bin/bash"]
CMD ["run.sh"]
