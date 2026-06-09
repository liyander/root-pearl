# Challenge 4: Root Pearl (Easy)

**Category:** Forensics / Enumeration  
**Difficulty:** Easy  
**Points:** 150  
**Flag:** `blackperl{f1nd_th3_h1dd3n_f1l3}`

## Description

The flag is hidden somewhere on the system. Use enumeration techniques to find it.

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

It tells you to search for files with "flag" or "secret" in the name.

### Step 3: Search for Flag Files

```bash
find / -name "*flag*" 2>/dev/null
find / -name "*secret*" 2>/dev/null
```

You'll find: `/var/games/hidden/.secret_flag`

### Step 4: Read the Flag

```bash
cat /var/games/hidden/.secret_flag
```

Output:
```
blackperl{f1nd_th3_h1dd3n_f1l3}
```

**Note:** This challenge was redesigned to work within Render's container security restrictions (no_new_privs flag). Instead of privilege escalation, it focuses on file enumeration and finding hidden files.

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
