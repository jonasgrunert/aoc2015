import day02
import day01
import gleam/io
import gleam/list
import gleam/option
import gleam/result
import gleam_community/ansi
import helper
import simplifile
import tempo/duration
import tempo/instant

fn test_day(t: helper.Task) -> List(option.Option(helper.TestResult)) {
  let input1 = simplifile.read("./data/" <> t.day <> "_test.txt")
  let timer1 = instant.now()
  let result1 = result.map(input1, t.solve1)
  let time1 = instant.since(timer1)
  let input2 =
    simplifile.read("./data/" <> t.day <> "_test2.txt") |> result.or(input1)
  let timer2 = instant.now()
  let result2 = t.solve2 |> option.map(fn(f) { input2 |> result.map(f) })
  let time2 = instant.since(timer2)
  [
    option.Some(helper.TestResult(
      day: t.day,
      part: "1",
      expect: t.expect1,
      state: case result1 {
        Ok(a) ->
          case a == t.expect1 {
            True -> helper.Success
            False -> helper.Inequal
          }
        Error(e) ->
          case e {
            simplifile.Enoent -> helper.Skipped
            _ -> helper.Failure
          }
      },
      result: option.from_result(result1),
      time: time1,
    )),
    option.map(result2, fn(r2) {
      helper.TestResult(
        day: t.day,
        part: "2",
        expect: t.expect2,
        state: case r2 {
          Ok(a) ->
            case a == t.expect2 {
              True -> helper.Success
              False -> helper.Inequal
            }
          Error(e) ->
            case e {
              simplifile.Enoent -> helper.Skipped
              _ -> helper.Failure
            }
        },
        result: option.from_result(r2),
        time: time2,
      )
    }),
  ]
}

fn render_result(r: option.Option(helper.TestResult)) -> String {
  r
  |> option.map(fn(r) {
    "Day "
    <> r.day
    <> " Part 0"
    <> r.part
    <> " - "
    <> case r.state {
      helper.Success -> ansi.green("SUCCESS")
      helper.Inequal -> ansi.red("FAILURE")
      helper.Failure -> ansi.red("ERROR")
      helper.Skipped -> ansi.yellow("SKIPPED")
    }
    <> " - Time "
    <> duration.format_as(r.time, duration.Millisecond, 2)
    <> case r.state {
      helper.Inequal ->
        "\nExpected: "
        <> r.expect
        <> "\nGot: "
        <> option.unwrap(r.result, "None")
      _ -> ""
    }
    <> "\n"
  })
  |> option.unwrap("")
}

pub fn main() -> Nil {
  [day01.day(), day02.day()]
  |> list.flat_map(test_day)
  |> list.map(render_result)
  |> list.each(io.print)
}
