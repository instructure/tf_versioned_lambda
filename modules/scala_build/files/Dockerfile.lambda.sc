FROM lambci/lambda:build

ENV AWS_DEFAULT_REGION us-east-1
ARG LAMBDA_DEST
ARG JAR_PATH
ARG CONFIG_FILE_DEST=src/main/resources/config.json
ARG SBT_TASK_NAME=assembly
ARG SBT_VERSION=1.1.5

ENV LAMBDA_DEST $LAMBDA_DEST
ENV JAR_PATH $JAR_PATH

RUN mkdir -p /opt && \
    cd /opt && \
    curl -O -J -L https://piccolo.link/sbt-"$SBT_VERSION".tgz && \
    tar xf sbt-"$SBT_VERSION".tgz && \
    rm -rf sbt-"$SBT_VERSION".tgz && \
    chown -R root:root sbt

WORKDIR /app/

COPY . /app/
RUN mkdir -p $(dirname "$CONFIG_FILE_DEST")
COPY config.json $CONFIG_FILE_DEST

RUN /opt/sbt/bin/sbt "$SBT_TASK_NAME"

CMD /app/build_lambda.sh
