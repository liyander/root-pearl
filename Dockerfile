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

RUN mkdir -p /opt/ctf && \
    echo "blackperl{su1d_b1n4ry_r34ds_th3_fl4g}" > /opt/ctf/flag.txt && \
    chmod 400 /opt/ctf/flag.txt && \
    chown root:root /opt/ctf/flag.txt && \
    chmod 755 /opt/ctf

RUN echo '#include <stdio.h>' > /tmp/readflag.c && \
    echo '#include <stdlib.h>' >> /tmp/readflag.c && \
    echo '#include <unistd.h>' >> /tmp/readflag.c && \
    echo 'int main() {' >> /tmp/readflag.c && \
    echo '    setuid(0);' >> /tmp/readflag.c && \
    echo '    setgid(0);' >> /tmp/readflag.c && \
    echo '    printf("=== Flag Reader ===\\n");' >> /tmp/readflag.c && \
    echo '    printf("This program can read the flag\\n\\n");' >> /tmp/readflag.c && \
    echo '    FILE *fp = fopen("/opt/ctf/flag.txt", "r");' >> /tmp/readflag.c && \
    echo '    if (fp == NULL) {' >> /tmp/readflag.c && \
    echo '        printf("Error: Cannot open flag file\\n");' >> /tmp/readflag.c && \
    echo '        perror("Details");' >> /tmp/readflag.c && \
    echo '        return 1;' >> /tmp/readflag.c && \
    echo '    }' >> /tmp/readflag.c && \
    echo '    char buffer[256];' >> /tmp/readflag.c && \
    echo '    while (fgets(buffer, sizeof(buffer), fp) != NULL) {' >> /tmp/readflag.c && \
    echo '        printf("%s", buffer);' >> /tmp/readflag.c && \
    echo '    }' >> /tmp/readflag.c && \
    echo '    fclose(fp);' >> /tmp/readflag.c && \
    echo '    return 0;' >> /tmp/readflag.c && \
    echo '}' >> /tmp/readflag.c && \
    gcc -o /usr/local/bin/readflag /tmp/readflag.c && \
    chown root:root /usr/local/bin/readflag && \
    rm /tmp/readflag.c

RUN echo '#!/bin/bash' > /home/ctfuser/hint.txt && \
    echo 'Welcome to the Root Pearl challenge!' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'The flag is stored in a file that only root can read.' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'However, there is a special program that can read it for you.' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'Try: find / -perm -4000 2>/dev/null' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'Then run the program you find!' >> /home/ctfuser/hint.txt && \
    chmod 444 /home/ctfuser/hint.txt && \
    chown ctfuser:ctfuser /home/ctfuser/hint.txt

RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'chmod 4755 /usr/local/bin/readflag' >> /entrypoint.sh && \
    echo 'exec ttyd -p 10000 -W login -f ctfuser' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

EXPOSE 10000

CMD ["/entrypoint.sh"]
