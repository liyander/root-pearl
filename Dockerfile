FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    ttyd \
    python3 \
    curl \
    netcat \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ctfuser && \
    echo "ctfuser:ctfuser" | chpasswd

RUN mkdir -p /var/games/hidden && \
    echo "blackperl{f1nd_th3_h1dd3n_f1l3}" > /var/games/hidden/.secret_flag && \
    chmod 644 /var/games/hidden/.secret_flag && \
    chown root:root /var/games/hidden/.secret_flag && \
    chmod 755 /var/games/hidden

RUN echo '#!/bin/bash' > /home/ctfuser/hint.txt && \
    echo 'Welcome to the Root Pearl challenge!' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'The flag is hidden somewhere on this system.' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'Try searching for files with "flag" or "secret" in the name:' >> /home/ctfuser/hint.txt && \
    echo '  find / -name "*flag*" 2>/dev/null' >> /home/ctfuser/hint.txt && \
    echo '  find / -name "*secret*" 2>/dev/null' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'Or look for hidden files (starting with a dot):' >> /home/ctfuser/hint.txt && \
    echo '  find / -name ".*" -type f 2>/dev/null | grep -v "/proc\|/sys"' >> /home/ctfuser/hint.txt && \
    chmod 444 /home/ctfuser/hint.txt && \
    chown ctfuser:ctfuser /home/ctfuser/hint.txt

RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'exec ttyd -p 10000 -W login -f ctfuser' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

EXPOSE 10000

CMD ["/entrypoint.sh"]
