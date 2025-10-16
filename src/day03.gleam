import gleam/int
import gleam/list
import gleam/option
import gleam/set
import gleam/string
import helper

fn next_pos(dir: String, pos: #(Int, Int)) {
  case dir {
    "<" -> #(pos.0 - 1, pos.1)
    ">" -> #(pos.0 + 1, pos.1)
    "^" -> #(pos.0, pos.1 + 1)
    "v" -> #(pos.0, pos.1 - 1)
    _ -> pos
  }
}

fn houses(dir: String, pos: List(#(Int, Int)), visited: set.Set(#(Int, Int))) {
  let #(state, new_pos) =
    pos
    |> list.map_fold(from: #(dir, visited), with: fn(memo, p) {
      let new_visited = set.insert(memo.1, p)
      case string.pop_grapheme(memo.0) {
        Ok(v) -> #(#(v.1, new_visited), next_pos(v.0, p))
        Error(_) -> #(#("", new_visited), p)
      }
    })
  case string.is_empty(state.0) {
    True -> new_pos |> list.fold(state.1, set.insert)
    False -> houses(state.0, new_pos, state.1)
  }
}

fn solve(pos: List(#(Int, Int))) {
  fn(t: String) { houses(t, pos, set.new()) |> set.size |> int.to_string }
}

pub fn day() {
  helper.Task(
    "03",
    solve([#(0, 0)]),
    "2",
    option.Some(solve([#(0, 0), #(0, 0)])),
    "11",
  )
}
