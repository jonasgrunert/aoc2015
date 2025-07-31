import helper

fn count(level: Int, rest: String) -> Int {
  case rest {
    "" -> level
    "(" <> rem -> count(level + 1, rem)
    ")" <> rem -> count(level - 1, rem)
    _ -> level
  }
}

pub fn day() {
  helper.Task("01", fn(t) { count(0, t) }, 3)
}
