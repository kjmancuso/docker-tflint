FROM alpine:latest
MAINTAINER "Kevin Mancuso <kevin@mancu.so>"

ENV TERRAFORM_VERSION=0.11.3
ENV TERRAFORM_SHA256SUM=6b8a7b83954597d36bbed23913dd51bc253906c612a070a21db373eab71b277b

RUN apk add --update git curl openssh && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN curl -Lo tflint.zip https://github.com/wata727/tflint/releases/download/v0.5.4/tflint_linux_amd64.zip && \
    unzip tflint.zip -d /bin && \
    rm -f tflint.zip

RUN apk add findutils bash coreutils

COPY pull-request.sh /bin/
