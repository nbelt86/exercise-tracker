# Exercise Tracker

A full-stack Rails workout tracker. Log workouts, track sets and reps per exercise, duplicate past sessions, search a built-in exercise catalog, and see weekly stats (volume lifted, workout streak) on your dashboard.

## Features

- **Workouts** — create, edit, delete, and duplicate past workout sessions
- **Exercise catalog** — searchable by name or muscle group (`Exercise` model, seeded with ~40 exercises across chest/back/legs/shoulders/arms/core/cardio)
- **Sets & reps** — log reps and weight per set, per exercise, within a workout
- **Dashboard stats** — current workout streak, workouts this week, total volume (reps × weight) this week
- **Auth** — Devise-based sign up / sign in, plus a **guest mode** ("Continue as Guest" on the sign-in page) that spins up a throwaway account pre-loaded with a sample workout, and deletes it automatically on sign-out

## Stack

- Ruby 3.3.5, Rails 7.1.6
- SQLite in development/test (zero setup), PostgreSQL in production via `DATABASE_URL`
- Hotwire (Turbo + Stimulus), Tailwind CSS, importmap-rails (no Node/bundler build step)
- Devise for authentication

## Setup

```bash
bin/setup        # installs gems, prepares the db, clears logs/tmp
bin/rails server
```

Then visit `http://localhost:3000`. Sign up for an account, or click **Continue as Guest** on the sign-in page to explore immediately with sample data.

To (re)seed the exercise catalog:

```bash
bin/rails db:seed
```

## Running tests

```bash
bin/rails test
```

## Deployment

A `render.yaml` is included for one-click deploy on [Render](https://render.com) as a Blueprint (free Docker web service + free Postgres database, wired together automatically). No third-party API keys are required — just set `RAILS_MASTER_KEY` (from `config/master.key`) as a secret env var.
