FROM lambci/lambda:build

ENV AWS_DEFAULT_REGION us-east-1
ARG LAMBDA_DEST
ARG JAR_PATH
ARG CONFIG_FILE_DEST=src/main/resources/config.json
ARG SBT_TASK_NAME=assembly

ENV LAMBDA_DEST $LAMBDA_DEST
ENV JAR_PATH $JAR_PATH

RUN mkdir -p /opt && \
    cd /opt && \
    curl -O -J -L https://dl.bintray.com/sbt/native-packages/sbt/0.13.12/sbt-0.13.12.tgz && \
    tar xvf sbt-0.13.12.tgz && \
    rm -rf sbt-0.13.12.tgz && \
    chown -R root:root sbt

WORKDIR /app/

COPY . /app/
RUN mkdir -p $(dirname "$CONFIG_FILE_DEST")
COPY config.json $CONFIG_FILE_DEST

RUN /opt/sbt/bin/sbt "$SBT_TASK_NAME"

CMD /app/build_lambda.sh
