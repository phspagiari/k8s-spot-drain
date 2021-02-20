FROM alpine:latest

RUN mkdir -p /app
WORKDIR /app
RUN apk -Uuv add curl ca-certificates bash
RUN apk --purge -v del py-pip && \
    update-ca-certificates && \
	rm /var/cache/apk/*

ADD run.sh /app/run.sh

ENTRYPOINT ["/bin/bash"]
CMD ["run.sh"]
