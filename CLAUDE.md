# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
bin/rails server          # Start dev server (localhost:3000)
bin/rails console         # Rails console
bin/rails db:migrate      # Run pending migrations
bin/rails db:seed         # Seed the database
bin/rails test            # Run all tests
bin/rails test test/path/to/specific_test.rb  # Run a single test file
bin/rails routes          # List all routes
```

## Architecture

Rails 7.1 app with SQLite, Hotwire (Turbo + Stimulus), importmap (no Node/webpack), and `simple_form`.

### Data model

The core domain is a workout logging app with a 4-level hierarchy:

```
Workout
  └── ExerciseEntry (join: workout + exercise)
        └── SetEntry (set_number, reps, weight)

Exercise (reference table: name, muscles_target, description)
```

- `Workout` has many `ExerciseEntry` records
- `ExerciseEntry` belongs to both a `Workout` and an `Exercise`, and has many `SetEntry` records
- `SetEntry` captures one set (set_number, reps, weight) for an exercise within a workout
- `Exercise` is a reference/catalog table — not owned by a workout

### Routes

Nested resources:

```
workouts/:id/exercise_entries          POST, DELETE
workouts/:id/exercise_entries/:id/set_entries  POST, PATCH, DELETE
exercises                              GET index, show
root → workouts#index
```

### What's built vs. what's pending

Workouts controller (index, show, new, create) and views exist. `ExerciseEntriesController` (create, destroy) and `SetEntriesController` (create, update, destroy) are implemented, and the workouts `show` view renders the full exercise/set hierarchy with forms to add exercises and sets.

`exercises` routes (`index`, `show`) are defined but `ExercisesController` and its views have not been created yet.
