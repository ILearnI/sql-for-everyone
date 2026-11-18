# Streamly practice database

This folder gives you the second database of the course "SQL for Everyone" (chapters 14 to 20): a video-streaming service with users, plans, subscriptions,
payments, viewing events and support tickets, plus a deliberately messy contacts table for the cleaning lessons.

## Option 1 (recommended): Docker

1. Install Docker Desktop (Mac, Windows) or Docker Engine (Linux) and start it.
2. Open a terminal in this folder and run:

       docker compose up -d --wait

   The first start loads the data and takes a few seconds. The command returns when the database is ready.
3. Open psql:

       docker compose exec db psql

   You should see the `streamly=#` prompt. Try: `SELECT count(*) FROM users;`
4. Leave psql with `\q`.

Handy commands:

| What | Command |
|---|---|
| Stop the database (keeps your data) | `docker compose stop` |
| Start it again | `docker compose start` |
| Start over with fresh data (deletes your changes) | `docker compose down -v` then `docker compose up -d --wait` |

Your own `.sql` files and `contacts_raw.csv` live in the `work` folder. Inside psql they are at `/work`,
for example `\i /work/my_query.sql`.

## Option 2: a normal PostgreSQL installation

1. Install PostgreSQL 17 (or newer) and make sure `psql` works.
2. Create the database and load the data:

       createdb streamly
       psql -d streamly -f init/01-streamly.sql

3. Copy `psqlrc` to your home folder as `.psqlrc` (on Windows: `%APPDATA%\postgresql\psqlrc.conf`).
4. Start with `psql -d streamly`.

The files in `work` are in this folder, so use their real path in `\copy` and `\i` commands.
