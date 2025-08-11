import gleam/int
import gleam/option
import helper

fn count(level: Int, rest: String) -> Int {
  case rest {
    // this does not optimze for tail recursion, but I am unsure how to do this
    "(" <> rem -> count(level + 1, rem)
    ")" <> rem -> count(level - 1, rem)
    _ -> level
  }
}

fn enter(level: Int, rest: String, pos: Int) -> Int {
  case level < 0 {
    True -> pos
    _ ->
      case rest {
        // this does not optimze for tail recursion, but I am unsure how to do this
        "(" <> rem -> enter(level + 1, rem, pos + 1)
        ")" <> rem -> enter(level - 1, rem, pos + 1)
        _ -> pos
      }
  }
}

pub fn day() {
  helper.Task(
    "01",
    fn(t) { count(0, t) |> int.to_string },
    "3",
    option.Some(fn(t) { enter(0, t, 0) |> int.to_string }),
    "5",
  )
}
