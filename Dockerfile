FROM golang:1.22-alpine AS builder

RUN apk add --no-cache wget tar

WORKDIR /build
RUN wget https://github.com/ArtalkJS/Artalk/releases/download/v2.9.1/artalk_v2.9.1_linux_amd64.tar.gz && \
    tar -zxvf artalk_v2.9.1_linux_amd64.tar.gz --strip-components=1

FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates tzdata && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /build/artalk /app/artalk
COPY artalk.yml /app/artalk.yml
COPY start.sh /app/start.sh

RUN chmod +x /app/artalk /app/start.sh

## Railway 通过 PORT 环境变量动态分配端口
EXPOSE 8080

CMD ["/app/start.sh"]
