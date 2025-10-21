import gleam/dict
import gleam/int
import gleam/list
import gleam/option
import gleam/string
import helper

type State1 {
  State1(previous: String, vocals: Int, double: Bool)
}

fn next_state1(s: State1, curr: String) {
  case s.previous, curr {
    p, "a" | p, "e" | p, "i" | p, "o" | p, "u" ->
      Ok(State1(curr, s.vocals + 1, s.double || curr == p))
    "a", "b" | "c", "d" | "p", "q" | "x", "y" -> Error(Nil)
    p, _ -> Ok(State1(curr, s.vocals, s.double || curr == p))
  }
}

fn is_nice1(s: State1) {
  s.vocals > 2 && s.double
}

type State2 {
  State2(
    prev: String,
    sec: String,
    paired: Bool,
    pairs: dict.Dict(String, Int),
    triplet: Bool,
  )
}

fn next_state2(s: State2, curr: String) {
  Ok(State2(
    prev: curr,
    sec: s.prev,
    paired: case s.paired {
      True -> False
      False -> s.prev == curr
    },
    pairs: case s.paired && s.prev == curr {
      True -> s.pairs
      False ->
        dict.upsert(s.pairs, s.prev <> curr, fn(i) { option.unwrap(i, 0) + 1 })
    },
    triplet: s.triplet || s.sec == curr,
  ))
}

fn is_nice2(s: State2) {
  dict.to_list(s.pairs) |> list.any(fn(e) { string.length(e.0) > 1 && e.1 > 1 })
  && s.triplet
}

fn check_string(
  t: String,
  s: state,
  next: fn(state, String) -> Result(state, Nil),
  is_nice: fn(state) -> Bool,
) {
  case string.pop_grapheme(t) {
    Error(_) -> is_nice(s)
    Ok(#(c, rem)) ->
      case next(s, c) {
        Error(_) -> False
        Ok(n) -> check_string(rem, n, next, is_nice)
      }
  }
}

fn count_nice(
  init: state,
  next: fn(state, String) -> Result(state, Nil),
  is_nice: fn(state) -> Bool,
) {
  fn(t: String) {
    string.split(t, "\n")
    |> list.count(fn(s) { check_string(s, init, next, is_nice) })
    |> int.to_string
  }
}

pub fn day() {
  helper.Task(
    "05",
    count_nice(State1("", 0, False), next_state1, is_nice1),
    "2",
    option.Some(count_nice(
      State2("", "", False, dict.new(), False),
      next_state2,
      is_nice2,
    )),
    "3",
  )
}
