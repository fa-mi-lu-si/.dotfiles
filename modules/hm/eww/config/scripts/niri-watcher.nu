#!/usr/bin/env nu

def main [config_path] {

  niri msg -j event-stream | lines | each {
    let event = $in | from json

    # TODO: open the bar if the workspace is empty
    # close the bar when a window is opened

    # Handle overview state changes
    $event | get --optional OverviewOpenedOrClosed.is_open
    | match $in {
      true => {
        eww -c $config_path open sidebar
        | ignore
      }
      false => {
        # TODO: do not close on empty workspace
        eww -c $config_path close ...(eww -c $config_path list-windows | lines)
        | ignore
      }
      _ => {ignore}
    }

    # handle other events and pass to eww  
  }
}
