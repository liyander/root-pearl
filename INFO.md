# Root Pearl

## Challenge Info

| Field | Details |
|-------|---------|
| **Name** | Root Pearl |
| **Category** | Forensics / Enumeration |
| **Difficulty** | Easy |
| **Points** | 150 |
| **Flag Format** | `blackperl{...}` |
| **Access** | Web browser (ttyd terminal) |
| **Technologies** | Linux, file enumeration |

## Description

The flag is hidden somewhere on the system. Use enumeration techniques to find it.

## Objective

Find a hidden flag file on the system using file search commands.

## What You Will Learn

- How to use `find` command to search for files
- How to search for hidden files (starting with a dot)
- Basic Linux file system navigation
- Enumeration techniques for CTF challenges

## Skills Required

- Basic Linux command line
- Understanding of `find` command
- Knowledge of hidden files in Linux

## Hints

1. Read the hint file at `/home/ctfuser/hint.txt`.
2. Use `find / -name "*flag*" 2>/dev/null` to search for files with "flag" in the name.
3. Use `find / -name "*secret*" 2>/dev/null` to search for files with "secret" in the name.
4. Look for hidden files: `find / -name ".*" -type f 2>/dev/null | grep -v "/proc\|/sys"`

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

## Note

This challenge was redesigned to work within Render's container security restrictions. The original privilege escalation version (using SUID binaries) does not work on Render due to the `no_new_privs` security flag. The new version focuses on file enumeration instead.
