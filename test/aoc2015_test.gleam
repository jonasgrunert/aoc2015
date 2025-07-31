import helper
import gleam/list
import gleam/result
import gleam/io
import simplifile
import day01

fn test_day(t: helper.Task(value)) -> Result(Nil, simplifile.FileError) {
  result.map(simplifile.read("./data/"<>t.day<>".txt"), fn(input) {
    assert t.solve1(input) == t.expect1
  })
}

pub fn main() -> Nil {
  [day01.day()]
  |> list.map(test_day)
  |> list.each(fn(r){
    case r {
      Ok(_) -> Nil
      _ -> io.println("Skipped due to error")
    }
  })
}
