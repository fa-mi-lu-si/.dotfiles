{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$directory"
        "$python"
        "$rust"
        "$nix_shell"
        "\${env_var.YAZI_LEVEL}"
        "$fill"
        "\${custom.git_host}"
        "$git_branch$git_commit"
        "$git_state$git_status"
        "\${custom.git_last_commit}"
        "$package"
        "$line_break"
        "$username"
        "$hostname"
        "$character"
      ];
      right_format = "$sudo$jobs";
      battery.display = {
        threshold = 30;
        discharging_symbol = "󰂃 ";
        charging_symbol = "󰂄 ";
      };
      sudo = {
        disabled = false;
        format = "[$symbol]($style)";
        symbol = "󱑷 ";
      };
      fill.symbol = " ";
      line_break.disabled = false;
      directory = {
        # TODO: shorten long paths
        truncation_length = 0;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
        before_repo_root_style = "bold cyan";
        repo_root_style = "bold cyan";
        repo_root_format = "[ $repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        read_only = " ";

        substitutions = {
          "~/Documents" = "󰈙 ";
          "~/Downloads" = " ";
          "~/Desktop" = "󰇄 ";
          "~/Music" = "󰝚 ";
          "~/Pictures" = " ";
          "~/Projects" = " ";
          "~/Videos" = " ";
          "~/.config" = ".󰒓 ";
          "~/.dotfiles" = ". ";
        };
      };

      git_branch = {
        symbol = "";
        format = "[$symbol $branch]($style) ";
      };
      git_status = {
        format = "[($conflicted$untracked$modified$staged$renamed$deleted)($ahead_behind$stashed)]($style)";
        ahead = "⇡$count ";
        behind = "[⇣$count](red)";
        conflicted = "🏳";
        deleted = "󰗨 $count ";
        diverged = "⇕⇡$ahead_count [⇣$behind_count](red) ";
        modified = " $count ";
        renamed = "󰾵 ";
        staged = "[++$count](green) ";
        stashed = " $count ";
        untracked = "[ $count](sapphire) ";
        style = "red";
        up_to_date = "";
      };
      git_state.format = "\([$state( $progress_current/$progress_total)]($style)\) ";

      # TODO: add other languages, lua, arduino, cpp
      python = {
        symbol = " ";
        format = "[$symbol$virtualenv]($style)";
      };
      rust = {
        format = "via [$symbol]($style)";
      };
      nix_shell = {
        symbol = " ";
        heuristic = false;
      };

      env_var.YAZI_LEVEL = {
        description = "Display for yazi shell";
        format = "in [󰇥 ]($style)";
        style = "yellow bold";
      };

      custom = {
        git_host = {
          description = "Display symbol for remote Git server";
          shell = ["sh" "--norc" "--noprofile"];
          format = "[$output]($style) ";
          style = "white bold";
          command = builtins.readFile ./git_host.sh;
          when = "git rev-parse --is-inside-work-tree 2> /dev/null";
          directories = [".git"];
        };

        git_last_commit = {
          description = "Show time since last commit";
          shell = ["sh" "--norc" "--noprofile"];
          format = "[ $output]($style) ";
          style = "yellow bold";
          command = ''
            git log --pretty=format:'%cr' -1
          '';
          when = "git rev-parse --is-inside-work-tree 2> /dev/null";
          directories = [".git"];
        };
      };
    };
  };
}
