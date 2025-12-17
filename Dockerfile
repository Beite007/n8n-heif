FROM n8nio/n8n:2.0.2

USER root

RUN set -eux; \
    if command -v apk >/dev/null 2>&1; then \
        apk add --no-cache libheif libheif-tools; \
    elif command -v apt-get >/dev/null 2>&1; then \
        apt-get update; \
        apt-get install -y --no-install-recommends libheif-examples; \
        rm -rf /var/lib/apt/lists/*; \
    else \
        echo "No supported package manager found (apk/apt-get)"; \
        exit 1; \
    fi

# 👇👇👇【关键新增部分】👇👇👇
RUN npm install -g n8n-nodes-feishu-lark

USER node
