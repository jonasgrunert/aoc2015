import gleam/int
import gleam/list
import gleam/option
import gleam/result
import gleam/string
import helper

fn solve(with: fn(List(Int)) -> Int) -> fn(String) -> String {
  fn(t) {
    string.split(t, "\n")
    |> list.map(parse_dim)
    |> result.all
    |> result.map(fn(l) {
      l
      |> list.map(with)
      |> list.fold(0, fn(p, c) { p + c })
      |> int.to_string
    })
    |> result.unwrap("-1")
  }
}

fn parse_dim(dim: String) {
  string.split(dim, "x")
  |> list.map(int.parse)
  |> result.all
}

fn paper(dim: List(Int)) {
  let #(w, s) =
    list.combination_pairs(dim)
    |> list.map(fn(t) { t.0 * t.1 })
    |> list.fold(#(0, 1_000_000), fn(p, c) { #(p.0 + c, int.min(p.1, c)) })
  w * 2 + s
}

fn ribbon(dim: List(Int)) {
  let r =
    list.combination_pairs(dim)
    |> list.map(fn(t) { 2 * { t.0 + t.1 } })
    |> list.fold(1_000_000, int.min)
  r + list.fold(dim, 1, fn(p, c) { p * c })
}

pub fn day() {
  helper.Task("02", solve(paper), "101", option.Some(solve(ribbon)), "48")
}
