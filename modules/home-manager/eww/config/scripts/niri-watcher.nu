#!/usr/bin/env nu

def main [config_path] {

  # TODO fix this config arg
  let config_arg = if ($config_path | is-empty) {""} else {$"-c ($config_path)"}

  niri msg -j event-stream | lines | each {
    let event = $in | from json

    # Handle overview state changes
    $event | get -i OverviewOpenedOrClosed.is_open
    | match $in {
      true => {
        eww $config_arg open sidebar
        | ignore
      }
      false => {
        # eww $config_arg close sidebar
        eww $config_arg close ...(eww -c. list-windows | lines)
        | ignore
      }
      _ => {ignore}
    }

    # handle other events and pass to eww  
  }
}
