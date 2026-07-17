{
  self,
  inputs,
}: final: prev: {
  # TODO : remove this on next fzf release
  fzf = final.symlinkJoin {
    inherit (prev.fzf) pname version;
    name = "${prev.fzf.pname}-${prev.fzf.version}";
    meta = builtins.removeAttrs prev.fzf.meta ["outputsToInstall"];
    paths = [prev.fzf];
    postBuild = ''
      rm "$out/bin/fzf"
      cat > "$out/bin/fzf" <<'EOF'
      #!${final.runtimeShell}
      if [ "$#" -eq 1 ] && [ "$1" = --nushell ]; then
        set -o pipefail
        ${prev.fzf}/bin/fzf --nushell | ${final.gnused}/bin/sed 's/str downcase/str lowercase/g'
      else
        exec ${prev.fzf}/bin/fzf "$@"
      fi
      EOF
      chmod +x "$out/bin/fzf"
    '';
  };
}
