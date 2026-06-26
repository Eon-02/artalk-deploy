FROM golang:1.22-alpine AS builder

RUN apk add --no-cache wget tar

WORKDIR /build
RUN wget https://github.com/ArtalkJS/Artalk/releases/download/v2.9.1/artalk_v2.9.1_linux_amd64.tar.gz && \
    tar -zxvf artalk_v2.9.1_linux_amd64.tar.gz

FROM alpine:3.19

RUN apk add --no-cache ca-certificates tzdata

WORKDIR /app

COPY --from=builder /build/artalk /app/artalk
COPY artalk.yml /app/artalk.yml
COPY start.sh /app/start.sh

RUN chmod +x /app/artalk /app/start.sh

# Hugging Face Spaces 默认端口
EXPOSE 7860

CMD ["/app/start.sh"]
