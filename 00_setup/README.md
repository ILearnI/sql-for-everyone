# Setup: three ways to run the course queries

You only need **one** of these. The first needs nothing at all.

## 1. In your browser: nothing to install

Every lesson has a playground that runs real PostgreSQL in your browser: copy a query, press Run, change it, reset the data any time.

- All playgrounds and exercises: https://www.codepion.com/exercises/udemy-sql-course/
- The playground hub: https://www.codepion.com/playground/

## 2. On your own computer with Docker (recommended for local practice)

Works the same on Mac, Windows and Linux, starts with one command, and you can reset everything with one more.

1. Install Docker Desktop (Mac, Windows) or Docker Engine (Linux) and start it.
2. Open a terminal in the folder of the database you need and run `docker compose up -d --wait`, then `docker compose exec db psql`.

| Database | Used in | Folder |
|---|---|---|
| Brewhouse (an online coffee shop) | chapters 1 to 13 | [`brewhouse-setup`](brewhouse-setup) |
| Streamly (a video-streaming service) | chapters 14 to 20 | [`streamly-setup`](streamly-setup) |

Run only one of them at a time: stop the first (`docker compose stop`) before you start the other.

## 3. With a normal PostgreSQL installation

Install PostgreSQL 17 or newer, then follow "Option 2" in the README of the database folder: create the database, load the data, copy the `psqlrc` file.

## Which script goes with which lesson?

See the main [README](../README.md): every lesson has a script in `03_scripts` and a playground link.
