FROM hashicorp/terraform:0.11.14

# install terraform-docs
RUN apk add --update curl bash && \
  rm -rf /var/cache/apk/* && \
  curl -L -o /bin/terraform-docs https://github.com/segmentio/terraform-docs/releases/download/v0.3.0/terraform-docs_linux_amd64 && \
  chmod a+x /bin/terraform-docs

RUN mkdir /app/
WORKDIR /app/
COPY . /app/

ENTRYPOINT []
CMD ["/app/validate.sh", "true"]
