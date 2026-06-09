#!/bin/bash
set -e

FLAG="blackperl{su1d_b1n4ry_r34ds_th3_fl4g}"

echo "$FLAG" > /root/flag.txt
chmod 400 /root/flag.txt

cat > /tmp/readflag.c << 'C_EOF'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    setuid(0);
    setgid(0);
    printf("=== Flag Reader ===\n");
    printf("This program can read /root/flag.txt\n\n");
    
    FILE *fp = fopen("/root/flag.txt", "r");
    if (fp == NULL) {
        printf("Error: Cannot open flag file\n");
        return 1;
    }
    
    char buffer[256];
    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        printf("%s", buffer);
    }
    fclose(fp);
    
    return 0;
}
C_EOF

gcc -o /usr/local/bin/readflag /tmp/readflag.c
chmod 4755 /usr/local/bin/readflag
rm /tmp/readflag.c

cat > /home/ctfuser/hint.txt << 'HINT_EOF'
Welcome to the Root Pearl challenge!

The flag is in /root/flag.txt but you can't read it directly.

However, there's a special program that can read it for you.

Try: find / -perm -4000 2>/dev/null

Then run the program you find!
HINT_EOF

chmod 444 /home/ctfuser/hint.txt
chown ctfuser:ctfuser /home/ctfuser/hint.txt

echo "Setup complete."
