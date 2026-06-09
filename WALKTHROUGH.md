# Challenge 4: Root Pearl (Easy)

**Category:** Privilege Escalation  
**Difficulty:** Easy  
**Points:** 150  
**Flag:** `blackperl{su1d_b1n4ry_r34ds_th3_fl4g}`

## Description

The flag is in /root/flag.txt but you can't read it. Find and run a SUID binary that can read it for you.

## Access

**Web Terminal:** Open the deployed URL in your browser (e.g., `https://root-pearl.onrender.com`)

A web-based terminal will appear. Login with:
- **Username:** `ctfuser`
- **Password:** `ctfuser`

## Walkthrough

### Step 1: Login

Open the web terminal URL in your browser and login as `ctfuser`.

### Step 2: Read the Hint

```bash
cat /home/ctfuser/hint.txt
```

It tells you to find SUID binaries.

### Step 3: Find SUID Binaries

```bash
find / -perm -4000 2>/dev/null
```

You'll find `/usr/local/bin/readflag`

### Step 4: Run the SUID Binary

```bash
readflag
```

Output:
```
=== Flag Reader ===
This program can read /root/flag.txt

blackperl{su1d_b1n4ry_r34ds_th3_fl4g}
```

## Running Locally

```bash
docker build -t root-pearl .
docker run -d -p 10000:10000 --name root-pearl root-pearl
```

Visit http://localhost:10000 in your browser.

## Deploying to Render

1. Push to GitHub
2. Create new Web Service on Render
3. Configure:
   - **Root Directory:** `challenges/root-pearl`
   - **Runtime:** `Docker`
   - **Environment Variable:** `PORT=10000`
4. Deploy

Players access the challenge via the Render URL in their browser.
