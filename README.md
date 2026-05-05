# Advent of Code Elixir

Elixir solutions for Advent of Code

## Requirements

- Elixir 1.14 or newer
- Mix

## Project Layout

Solutions are grouped by year and day:

```text
lib/aoc_ex/year_2025/day_03/day_03.ex
lib/aoc_ex/year_2025/day_03/input.txt
test/aoc_ex/year_2025/day_03/day_03_test.exs
```

Shared helpers live in:

```text
lib/aoc_ex/day_utils.ex
lib/aoc_ex/input_utils.ex
lib/aoc_ex/solution_runner.ex
lib/timer.ex
```

Templates for new days live in:

```text
priv/templates/aoc_day/
```

## Run A Solution

```sh
mix aoc.run 2025 03 --part 1
mix aoc.run 2025 03 --part 2
```

The runner loads the matching input file from:

```text
lib/aoc_ex/year_2025/day_03/input.txt
```

It also times the selected part with `Timer.measure/2`.

## Run Tests

Run the whole suite:

```sh
mix test
```

Run tests for one day:

```sh
mix aoc.test 2025 03
```

You can pass normal Mix test options after the day:

```sh
mix aoc.test 2025 03 --trace
```

## Create A New Day

Create a day for the default year, currently `2025`:

```sh
mix new_day 04
```

Create a day for a specific year:

```sh
mix new_day 2026 01
```

This creates:

```text
lib/aoc_ex/year_2026/day_01/day_01.ex
lib/aoc_ex/year_2026/day_01/input.txt
test/aoc_ex/year_2026/day_01/day_01_test.exs
```

## Input Files

Puzzle inputs are intentionally ignored by Git:

```text
input*.txt
```

Keep each input next to its solution:

```text
lib/aoc_ex/year_YYYY/day_XX/input.txt
```

## Formatting

```sh
mix format
mix format --check-formatted
```
