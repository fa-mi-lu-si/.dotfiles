{
  inputs,
  pkgs,
  config,
  ...
}: {
  programs.librewolf = {
    enable = true;
    profiles."default" = {
      name = "samy";
      isDefault = true;
      settings = {
        # Mandatory
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;

        "ui.key.menuAccessKeyFocuses" = false; # Remove ALT menu

        # Performance
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.dmabuf.force-enabled" = true;

        # Disable useless things
        "browser.aboutConfig.showWarning" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.tabs.tabmanager.enabled" = false;
        "reader.parse-on-load.enabled" = false;
        "browser.translations.enable" = false;
        "identity.fxaccounts.enabled" = false;
        "browser.vpn_promo.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        # Enable cool bahavior
        "browser.urlbar.trim" = true; # Trim https!
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.trimURLs" = true;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.startup.page" = 3; # Restore session
        "extensions.autoDisableScopes" = 0; # Auto-enable extesions
        "browser.tabs.loadBookmarksInTabs" = true; # Load bookmarks in newtabs
        "browser.search.openintab" = true; # Load search items in new tabs

        "layout.css.has-selector.enabled" = true;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;
        "browser.profiles.enabled" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "browser.compactmode.show" = true;
        "widget.gtk.ignore-bogus-leave-notify" = 1;
        "browser.tabs.allow_transparent_browser" = true;
        "browser.uidensity" = 1;

        # potatofox tweaks
        "uc.tweak.borderless" = true;
        "uc.tweak.no-panel-hint" = true;
        "uc.tweak.no-blur" = true;
      };
      extensions.force = true;
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        sidebery
        sponsorblock
        darkreader
        vimium-c
        userchrome-toggle-extended
        multi-account-containers

        firefox-color
      ];

      extensions.settings."FirefoxColor@mozilla.com".settings = let
        colors = config.lib.stylix.colors;
        mkColor = color: {
          r = colors."${color}-rgb-r";
          g = colors."${color}-rgb-g";
          b = colors."${color}-rgb-b";
        };
      in {
        firstRunDone = true;
        theme = {
          title = "Stylix ${colors.description}";
          images.additional_backgrounds = ["./bg-000.svg"];
          colors = {
            toolbar = mkColor "base00";
            toolbar_text = mkColor "base05";
            frame = mkColor "base00";
            tab_background_text = mkColor "base05";
            toolbar_field = mkColor "base02";
            toolbar_field_text = mkColor "base05";
            tab_line = mkColor "base0D";
            popup = mkColor "base00";
            popup_text = mkColor "base05";
            button_background_active = mkColor "base04";
            frame_inactive = mkColor "base00";
            icons_attention = mkColor "base0D";
            icons = mkColor "base05";
            ntp_background = mkColor "base00";
            ntp_text = mkColor "base05";
            popup_border = mkColor "base0D";
            popup_highlight_text = mkColor "base05";
            popup_highlight = mkColor "base04";
            sidebar_border = mkColor "base0D";
            sidebar_highlight_text = mkColor "base05";
            sidebar_highlight = mkColor "base0D";
            sidebar_text = mkColor "base05";
            sidebar = mkColor "base00";
            tab_background_separator = mkColor "base0D";
            tab_loading = mkColor "base05";
            tab_selected = mkColor "base00";
            tab_text = mkColor "base05";
            toolbar_bottom_separator = mkColor "base00";
            toolbar_field_border_focus = mkColor "base0D";
            toolbar_field_border = mkColor "base00";
            toolbar_field_focus = mkColor "base00";
            toolbar_field_highlight_text = mkColor "base00";
            toolbar_field_highlight = mkColor "base0D";
            toolbar_field_separator = mkColor "base0D";
            toolbar_vertical_separator = mkColor "base0D";
          };
        };
      };

      userContent =
        #css
        ''
          ${builtins.readFile "${inputs.potatofox}/chrome/userContent.css"}
        '';
    };
  };

  home.file.".librewolf/default/chrome" = {
    source = builtins.filterSource (path: type: baseNameOf path != "userContent.css") "${inputs.potatofox}/chrome";
    recursive = true;
  };

  stylix.targets.librewolf.profileNames = ["default"];
}
