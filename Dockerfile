
FROM n8nio/n8n:2.0.2

USER root

RUN set -eux; \
    if command -v apk >/dev/null 2>&1; then \
        # Alpine (musl)
        apk add --no-cache \
          libheif libheif-tools \
          python3 py3-pip py3-setuptools py3-wheel \
          jpeg-dev zlib-dev; \
        pip3 install --no-cache-dir --upgrade pip; \
        pip3 install --no-cache-dir pillow pillow-heif; \
    elif command -v apt-get >/dev/null 2>&1; then \
        # Debian/Ubuntu (glibc)
        apt-get update; \
        apt-get install -y --no-install-recommends \
          libheif-examples \
          python3 python3-pip python3-setuptools python3-wheel \
          libjpeg-dev zlib1g-dev; \
        rm -rf /var/lib/apt/lists/*; \
        pip3 install --no-cache-dir --upgrade pip; \
        pip3 install --no-cache-dir pillow pillow-heif; \
    else \
        echo "No supported package manager found (apk/apt-get)"; \
        exit 1; \
    fi

# 👇👇👇【关键新增部分】👇👇👇
RUN npm install -g n8n-nodes-feishu-lark

USER node
