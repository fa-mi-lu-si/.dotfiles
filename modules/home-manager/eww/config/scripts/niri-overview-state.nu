#!/usr/bin/env nu

niri msg -j event-stream | lines | each {
  $in | from json | get -i OverviewOpenedOrClosed.is_open
  | match $in {
    true => {
      eww open sidebar | ignore
    }
    false => {
      eww close sidebar | ignore
    }
    _ => {ignore}
  }
}
