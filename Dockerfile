FROM hashicorp/terraform

# install terraform-docs
RUN apk add --update curl bash && \
  rm -rf /var/cache/apk/* && \
  curl -L -o /bin/terraform-docs https://github.com/segmentio/terraform-docs/releases/download/v0.8.1/terraform-docs_linux_amd64 && \
  chmod a+x /bin/terraform-docs

RUN mkdir /app/
WORKDIR /app/
COPY . /app/
# exporting this allows us to run terraform 12 validate commands on modules.  Apparently v11 was insufficient.
# https://github.com/hashicorp/terraform/issues/21408
ENV AWS_DEFAULT_REGION=us-east-1

ENTRYPOINT []
CMD ["/app/validate.sh", "true"]
