import gleam/option
import gleam/time/duration

pub type ResultState {
  Success
  Inequal
  Failure
  Skipped
}

pub type Task {
  Task(
    day: String,
    solve1: fn(String) -> String,
    expect1: String,
    solve2: option.Option(fn(String) -> String),
    expect2: String,
  )
}

pub type TestResult {
  TestResult(
    day: String,
    part: String,
    state: ResultState,
    expect: String,
    result: option.Option(String),
    time: duration.Duration,
  )
}
