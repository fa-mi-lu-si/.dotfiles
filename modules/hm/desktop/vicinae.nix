{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    autoStart = true;
    settings = {
      closeOnFocusLoss = true;
      faviconService = "twenty";
      font = {size = 10.5;};
      keybinding = "default";
      keybinds = {};
      popToRootOnClose = true;
      rootSearch = {searchFiles = false;};
      theme = {name = "stylix";};
      window = {
        csd = true;
        opacity = 1;
        rounding = 4;
      };
    };
  };

  # Stylix theming for vicinae
  home.file.".local/share/vicinae/themes/stylix.toml".text = with config.lib.stylix.colors.withHashtag;
  # toml
    ''
      [meta]
      version = 1
      name = "stylix"
      description = "A stylix generated theme for Vicinae"
      variant = "dark"
      inherits = "vicinae-dark"

      [colors.core]
      accent = "${base0D}"              # Primary accent color (used for input borders, text selection background...)
      accent_foreground = "${base05}"   # Text color on accent-colored backgrounds
      background = "${base00}"          # Main application background
      foreground = "${base05}"          # Primary text color
      secondary_background = "${base02}" # Background for surfaces elevated above main (popups, tooltips, panels)
      border = "${base03}"              # Default border color throughout the UI

      [colors.accents]
      blue = "${base0D}"
      green = "${base0B}"
      magenta = "${base0F}"
      orange = "${base09}"
      red = "${base08}"
      yellow = "${base0A}"
      cyan = "${base0C}"
      purple = "${base0E}"

      [colors.text]
      default = "colors.core.foreground"             # Usually same as core.foreground
      muted = "colors.core.foreground"               # Secondary text: hints, less important info
      danger = "${base08}"              # Errors or warnings
      success = "${base0B}"             # Success or positive states
      placeholder = "colors.core.foreground"			# input placeholder, search placeholder...
      selection = { background = "${base02}", foreground = "${base05}" }

      [colors.text.links]
      default = "${base0D}"
      visited = "${base0E}"

      [colors.input]
      border = "colors.core.border"
      border_focus = "colors.core.accent"
      border_error = "${base08}"

      [colors.button.primary]
      background = "${base00}"
      foreground = "${base05}"
      hover = { background = "${base02}" }
      focus = { outline = "colors.core.accent" }


      [colors.list.item.hover]
      background = "${base01}"
      foreground = "${base05}"

      [colors.list.item.selection]
      background = "${base02}"          # Selected item on main background
      foreground = "${base05}"
      secondary_background = "${base02}" # Selected item on secondary surfaces (popups, panels)
                                       # Light themes: lighter than primary selection
                                       # Dark themes: lighter/brighter than primary selection
      secondary_foreground = "${base05}"

      [colors.grid.item]
      background = "colors.core.secondary_background"
      hover = { outline = "colors.core.foreground" }
      selection = { outline = "colors.core.foreground" }

      [colors.scrollbars]
      background = "colors.core.border"

      [colors.loading]
      bar = "colors.core.foreground"     # shown right below the search bar when something is loading
      spinner = "colors.core.foreground" # used by dynamic toasts
    '';
}
