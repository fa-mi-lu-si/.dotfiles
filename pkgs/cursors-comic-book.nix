{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  xcursorgen,
}:
stdenvNoCC.mkDerivation {
  pname = "macos-comic-book-cursors";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "tonsky";
    repo = "macos-cursors-comic-book";
    rev = "main"; # Prefer a pinned commit SHA.
    hash = "sha256-O5zZVNB6WpG8xIkkDEgPpjqgTk9xpebbq6+q8wG5gcE=";
  };

  nativeBuildInputs = [xcursorgen];

  installPhase = ''
    runHook preInstall

    themeDir="$out/share/icons/MacOS-Comic-Book"
    mkdir -p "$themeDir/cursors"

    cat > "$themeDir/index.theme" <<'EOF'
    [Icon Theme]
    Name=MacOS-Comic-Book
    Comment=macOS comic book cursor theme
    Inherits=Adwaita
    EOF

    cd "$themeDir/cursors"

    makeCursor() {
      name="$1"
      image="$2"
      hx="$3"
      hy="$4"

      base="$src/src/$image.png"
      retina="$src/src/$image@2x.png"
      conf="$TMPDIR/$name.cursor"

      if [ ! -f "$base" ]; then
        echo "Missing cursor image: $base" >&2
        exit 1
      fi

      printf '32 %s %s %s\n' \
        "$hx" "$hy" "$base" > "$conf"

      if [ -f "$retina" ]; then
        printf '64 %s %s %s\n' \
          "$((hx * 2))" "$((hy * 2))" "$retina" >> "$conf"
      fi

      xcursorgen "$conf" "$name"
    }

    aliases() {
      target="$1"
      shift

      for name in "$@"; do
        ln -sfn "$target" "$name"
      done
    }

    # Basic pointers
    makeCursor left_ptr arrow 4 2
    aliases left_ptr default arrow top_left_arrow
    aliases left_ptr left-arrow

    makeCursor watch busy 16 16
    aliases watch wait busy progress half-busy

    makeCursor text ibeam 16 16
    aliases text xterm ibeam vertical_text

    makeCursor pointer pointing 12 8
    aliases pointer hand hand1 hand2 pointing
    aliases pointer link

    # Copy / drag / forbidden
    makeCursor copy copy_drag 16 16
    aliases copy dnd-copy copy_drag
    aliases copy dnd-copy-link

    makeCursor not-allowed forbidden 16 16
    aliases not-allowed forbidden crossed_circle

    # Cardinal resize arrows
    makeCursor top_side window_n 16 16
    aliases top_side n-resize ns-resize window_n

    makeCursor bottom_side window_s 16 16
    aliases bottom_side s-resize window_s

    makeCursor right_side window_e 16 16
    aliases right_side e-resize window_e

    makeCursor left_side window_w 16 16
    aliases left_side w-resize window_w

    # Bidirectional resize arrows
    makeCursor ew-resize window_e_w 16 16
    aliases ew-resize h-resize size_hor col-resize \
      sb_h_double_arrow window_e_w

    makeCursor ns-resize window_n_s 16 16
    aliases ns-resize v-resize size_ver row-resize \
      sb_v_double_arrow window_n_s

    # Diagonal resize arrows
    makeCursor top_right_corner window_ne 16 16
    aliases top_right_corner ne-resize window_ne

    makeCursor top_left_corner window_nw 16 16
    aliases top_left_corner nw-resize window_nw

    makeCursor bottom_right_corner window_se 16 16
    aliases bottom_right_corner se-resize window_se

    makeCursor bottom_left_corner window_sw 16 16
    aliases bottom_left_corner sw-resize window_sw

    # Diagonal bidirectional arrows
    makeCursor nesw-resize window_ne_sw 16 16
    aliases nesw-resize size_bdiag fd_double_arrow window_ne_sw

    makeCursor nwse-resize window_nw_se 16 16
    aliases nwse-resize size_fdiag bd_double_arrow window_nw_se

    # Common names used by applications
    aliases left_ptr arrow top_left_arrow
    aliases text vertical-text
    aliases watch spinning
    aliases pointer pointing_hand

    runHook postInstall
  '';

  meta = {
    description = "macOS Comic Book Xcursor theme";
    platforms = lib.platforms.linux;
  };
}
