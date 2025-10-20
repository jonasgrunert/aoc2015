import gleam/bit_array
import gleam/crypto
import gleam/int
import gleam/option
import gleam/string
import helper

fn loop(t: String, m: String, count: Int) {
  let h = t <> int.to_string(count)
  let hash = crypto.hash(crypto.Md5, <<h:utf8>>) |> bit_array.base16_encode
  case string.starts_with(hash, m) {
    True -> count |> int.to_string
    False -> loop(t, m, count + 1)
  }
}

fn check_hash(length: Int) {
  let m = string.pad_start("", length, "0")
  fn(t: String) { loop(t, m, 1) }
}

pub fn day() {
  helper.Task(
    "04",
    check_hash(5),
    "1048970",
    option.Some(check_hash(6)),
    "5714438",
  )
}
