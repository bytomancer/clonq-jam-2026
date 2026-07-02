{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          libresprite
          godot_4_6
          godot_4_6-export-templates-bin
          zip
          wget
          ffmpeg
          sfxr
        ];
        shellHook = ''
          mkdir -p "$HOME/.local/share/godot"

          if [ ! -e "$HOME/.local/share/godot/export_templates" ]; then
            ln -s \
              ${pkgs.godot-export-templates-bin}/share/godot/export_templates \
              "$HOME/.local/share/godot/export_templates"
          fi
        '';
      };
    };
}
