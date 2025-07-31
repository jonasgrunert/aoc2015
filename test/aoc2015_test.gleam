import day01
import gleam/io
import gleam/list
import gleam/result
import helper
import simplifile

fn test_day(t: helper.Task(value)) -> Result(Nil, simplifile.FileError) {
  result.map(simplifile.read("./data/" <> t.day <> ".txt"), fn(input) {
    assert t.solve1(input) == t.expect1
  })
}

pub fn main() -> Nil {
  let _ = result.map(simplifile.read("./data/" <> "01" <> ".txt"), io.println)
  [day01.day()]
  |> list.map(test_day)
  |> list.each(fn(r) {
    case r {
      Ok(_) -> Nil
      _ -> io.println("Skipped day due to error")
    }
  })
}
