# Root Pearl

## Challenge Info

| Field | Details |
|-------|---------|
| **Name** | Root Pearl |
| **Category** | Privilege Escalation |
| **Difficulty** | Easy |
| **Points** | 150 |
| **Flag Format** | `blackperl{...}` |
| **Access** | Web browser (ttyd terminal) |
| **Technologies** | Linux, SUID binaries, ttyd |

## Description

The flag is in /root/flag.txt but you can't read it directly. Find a SUID binary that can read it for you.

## Objective

Find and execute a SUID binary to read a root-only flag file.

## What You Will Learn

- What SUID binaries are
- How to find SUID binaries using `find`
- How SUID binaries can be used to escalate privileges
- Using web-based terminals for remote challenges

## Skills Required

- Basic Linux command line
- Understanding of file permissions

## Hints

1. Read the hint file at `/home/ctfuser/hint.txt`.
2. Use `find / -perm -4000 2>/dev/null` to find SUID binaries.
3. Run the binary you find to read the flag.

## Tools Required

- Web browser
- Basic Linux commands (`find`, `cat`)

## Access Method

This challenge uses **ttyd** (web-based terminal) so players can access it through a browser:

1. Open the challenge URL in a web browser
2. A terminal interface appears
3. Login with credentials: `ctfuser` / `ctfuser`
4. Solve the challenge using standard Linux commands

## Setup

### Local (Docker)
```bash
docker build -t root-pearl .
docker run -d -p 10000:10000 --name root-pearl root-pearl
```

Visit http://localhost:10000

### Render Deployment
1. Push to GitHub
2. Create Web Service on Render
3. Set Root Directory: `challenges/root-pearl`
4. Set Runtime: `Docker`
5. Add env var: `PORT=10000`
6. Deploy

Players access via the Render URL in their browser.

## Files Provided

- Web-based terminal access
- Credentials: `ctfuser` / `ctfuser`
- Hint file at `/home/ctfuser/hint.txt`
