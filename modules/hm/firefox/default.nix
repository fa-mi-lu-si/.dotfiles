{
  inputs,
  pkgs,
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
      ];
    };
  };

  home.file.".librewolf/default/chrome" = {
    source = "${inputs.potatofox}/chrome";
    recursive = true;
  };

  stylix.targets.librewolf.profileNames = ["default"];
  stylix.targets.librewolf.colorTheme.enable = true;
}
