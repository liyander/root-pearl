#!/bin/bash
set -e

FLAG="blackperl{su1d_b1n4ry_r34ds_th3_fl4g}"

echo "$FLAG" > /root/flag.txt
chmod 400 /root/flag.txt

cat > /usr/local/bin/readflag << 'SUID_EOF'
#!/bin/bash
echo "=== Flag Reader ==="
echo "This program can read /root/flag.txt"
echo ""
cat /root/flag.txt
SUID_EOF

chmod 4755 /usr/local/bin/readflag

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
