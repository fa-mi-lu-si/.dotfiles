#! /usr/bin/env nu
let battery = "/sys/class/power_supply/BAT1/"
let percentage = [$battery "capacity"] | path join | open | str trim
let status = [$battery "status"] | path join | open | str trim

{
  percentage : $percentage
  icon : "" # TODO: add icons
} | to json
