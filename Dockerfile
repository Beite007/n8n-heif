FROM n8nio/n8n:2.2.6-debian

USER root

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends libheif-examples python3; \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g --legacy-peer-deps n8n-nodes-feishu-lark

USER node
