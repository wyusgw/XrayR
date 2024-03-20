# Build go
FROM golang:1.22.0-alpine AS builder
WORKDIR /app
COPY . .
ENV CGO_ENABLED=0
RUN go mod download \
    && go build -v -o XrayR -trimpath -ldflags "-s -w -buildid="

# Release
FROM  alpine
# 安装必要的工具包
RUN  apk --update --no-cache add tzdata ca-certificates \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && mkdir /etc/XrayR/
COPY --from=builder /app/XrayR /usr/local/bin

ENTRYPOINT [ "XrayR", "--config", "/etc/XrayR/config.yml"]
