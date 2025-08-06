{ inputs, ... }: {
  perSystem =
    { config
    , self'
    , pkgs
    , ...
    }: {
      devShells.default = pkgs.mkShell {
        name = "gignsky-dot-com-shell";
        inputsFrom = [
          self'.devShells.rust
          config.pre-commit.devShell # See ./nix/modules/pre-commit.nix
        ];
        packages = with pkgs; [
          just
          bacon
          config.process-compose.cargo-doc-live.outputs.package
          nil
          cargo-generate
          lazygit
          clippy

          # Formatting tools (replacing treefmt)
          nixpkgs-fmt
          rustfmt

          # gigdot programs
          inputs.gigdot.packages.${system}.quick-results
          inputs.gigdot.packages.${system}.upjust
          inputs.gigdot.packages.${system}.upspell
          inputs.gigdot.packages.${system}.upflake
          inputs.gigdot.packages.${system}.cargo-update

          # Dioxus and such
          dioxus-cli
        ];
        shellHook = ''
          echo "welcome to the rust development environment for the gignsky-dot-com package" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat 2> /dev/null;
        '';
      };
    };
}
