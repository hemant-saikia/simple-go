FROM alpine:latest
WORKDIR /app/
COPY --from=builder /go-workspace/src/github.com/saikiahemant/simple-go/simple-go /app/simple-go
EXPOSE 8888
ENTRYPOINT ./simple-go
