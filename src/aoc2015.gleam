import day01
import day02
import day03
import day04
import gleam/io
import gleam/list
import gleam/option
import gleam/result
import helper
import simplifile

fn execute_day(t: helper.Task) -> String {
  let input = simplifile.read("./data/" <> t.day <> ".txt")
  let result1 = input |> result.map(t.solve1)
  let result2 = t.solve2 |> option.map(fn(f) { input |> result.map(f) })
  "Day "
  <> t.day
  <> " Part 01: "
  <> { result1 |> result.unwrap("Error") }
  <> {
    result2
    |> option.map(fn(r) {
      "\nDay " <> t.day <> " Part 02: " <> r |> result.unwrap("Error") <> "\n"
    })
    |> option.unwrap("\n")
  }
}

pub fn main() {
  [day01.day(), day02.day(), day03.day(), day04.day()]
  |> list.map(execute_day)
  |> list.each(io.print)
}
