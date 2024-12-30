#! /usr/bin/env nu
let battery = "/sys/class/power_supply/BAT*/"
let percentage = [$battery "capacity"] | path join | open | str trim | into int
let status = [$battery "status"] | path join | open | str trim

let CHARGING_ICON = "󰚥"
let UNPLUGGED_ICONS = [
 "󰂃"
 "󰁻"
 "󰁼"
 "󰁽"
 "󰁾"
 "󰁿"
 "󰂀"
 "󰂁"
 "󰂂"
 "󱟢"
]

{
  percentage : $percentage
  icon : (
    if ($status == "Charging") {
      $CHARGING_ICON
    } else {
      $UNPLUGGED_ICONS | get (
        ($percentage / ($UNPLUGGED_ICONS | length)) | into int
      )
    }
  )
} | to json
