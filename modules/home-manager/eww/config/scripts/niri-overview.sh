#!/usr/bin/env bash

# Set config path if provided as argument
if [ $# -gt 0 ]; then
  config_arg="-c $1"
else
  config_arg=""
fi

niri msg -j event-stream | while IFS= read -r line; do
  # Extract is_open value using grep and sed
  if echo "$line" | grep -q '"OverviewOpenedOrClosed"'; then
    is_open=$(echo "$line" | grep -o '"is_open":[^,}]*' | sed 's/"is_open"://; s/[",]//g; s/ //g')
    
    case "$is_open" in
      true)
        eww $config_arg open sidebar >/dev/null 2>&1
        ;;
      false)
        eww $config_arg close sidebar >/dev/null 2>&1
        eww $config_arg close player >/dev/null 2>&1
        ;;
      *)
        # Do nothing for other cases
        ;;
    esac
  fi
done
