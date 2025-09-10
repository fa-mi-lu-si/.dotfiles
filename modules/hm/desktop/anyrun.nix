{
  pkgs,
  config,
  ...
}: {
  programs.anyrun = {
    enable = true;
    config = {
      x.fraction = 0.5;
      y.fraction = 0.3;
      width.fraction = 0.4;
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = null;

      plugins = [
        # "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libapplications.so"
        # "${pkgs.anyrun}/lib/libdictionary.so"
        # "${pkgs.anyrun}/lib/libkidex.so"
        # "${pkgs.anyrun}/lib/libniri_focus.so"
        # "${pkgs.anyrun}/lib/libnix_run.so"
        # "${pkgs.anyrun}/lib/librandr.so"
        "${pkgs.anyrun}/lib/librink.so"
        "${pkgs.anyrun}/lib/libshell.so"
        "${pkgs.anyrun}/lib/libstdin.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
        # "${pkgs.anyrun}/lib/libtranslate.so"
        "${pkgs.anyrun}/lib/libwebsearch.so"
      ];
    };

    extraCss = with config.lib.stylix.colors.withHashtag;
    # css
      ''
        /* GTK Vars */
        @define-color bg-color ${base00};
        @define-color fg-color ${base05};
        @define-color primary-color ${base0D};
        @define-color secondary-color ${base0E};
        @define-color border-color @primary-color;
        @define-color selected-bg-color @primary-color;
        @define-color selected-fg-color @bg-color;

        * {
          all: unset;
          font-family: ${config.stylix.fonts.sansSerif.name};
        }

        #window {
          background: transparent;
        }

        box#main {
          border-radius: 16px;
          background-color: @bg-color;
          border: 2px solid @primary-color;
        }

        entry#entry {
          font-size: 1.25rem;
          background: transparent;
          box-shadow: none;
          border: none;
          border-radius: 8px;
          padding: 8px 12px;
          min-height: 32px;
          caret-color: @primary-color;
        }

        list#main {
          background-color: transparent;
        }

        #plugin {
          background-color: transparent;
          padding-bottom: 4px;
        }

        #match {
          font-size: 1.1rem;
          padding: 2px 4px;
        }

        #match:selected,
        #match:hover {
          background-color: @selected-bg-color;
          color: @selected-fg-color;
        }

        #match:selected label#info,
        #match:hover label#info {
          color: @selected-fg-color;
        }

        #match:selected label#match-desc,
        #match:hover label#match-desc {
          color: @selected-fg-color;
        }

        #match label#info {
          color: transparent;
        }

        label#match-desc {
          font-size: 1rem;
          color: @fg-color;
        }
      '';

    extraConfigFiles = {
      "applications.ron".text =
        #ron
        ''
          Config(
            desktop_actions: false,
            max_entries: 5,
            terminal: Some(Terminal(
              command: "wezterm",
              args: "-e {}",
            )),
          )
        '';
      "websearch.ron".text =
        #ron
        ''
          Config(
            prefix: "?",
            engines: [DuckDuckGo]
          )
        '';
      "shell.ron".text =
        #ron
        ''
          Config(
            prefix: ":",
          )
        '';
      "symbols.ron".text =
        #ron
        ''
          Config(
            prefix: ".",
          )
        '';
    };
  };
}
