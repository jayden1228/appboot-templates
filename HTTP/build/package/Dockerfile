FROM makeblock/alpine

ARG tmp_api_version=default_value
ENV API_VERSION=$tmp_api_version

ADD {{.Name}} /app/

WORKDIR /app

EXPOSE 8000

CMD ["./{{.Name}}"]