FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    ttyd \
    python3 \
    curl \
    netcat \
    sudo \
    gcc \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ctfuser && \
    echo "ctfuser:ctfuser" | chpasswd

COPY setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh && /tmp/setup.sh && rm /tmp/setup.sh

RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'echo "=== Root Pearl CTF Challenge ==="' >> /entrypoint.sh && \
    echo 'echo "Login as ctfuser (password: ctfuser)"' >> /entrypoint.sh && \
    echo 'echo "Read /home/ctfuser/hint.txt to get started."' >> /entrypoint.sh && \
    echo 'exec /bin/bash' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

EXPOSE 10000

CMD ["ttyd", "-p", "10000", "-W", "login", "-f", "ctfuser"]
