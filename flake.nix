{
  description = "bindgen";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages.default = self.packages.${system}.linia;

        packages = {
          odinCBindgen = pkgs.stdenv.mkDerivation {
            pname = "odin-c-bindgen";
            version = self.shortRev or self.dirtyShortRev or "dev";
            src = ./.;
            nativeBuildInputs = [ pkgs.odin pkgs.libclang ];
            buildPhase = ''
              odin build src -out:bindgen
            '';
            installPhase = ''
              mkdir -p $out/bin
              cp bindgen $out/bin
            '';
          };
        };

        devShells = {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.odin
              self.packages.${system}.odinCBindgen
              pkgs.libclang
              # lsp
              pkgs.ols
            ];
            shellHook = ''
              export C_INCLUDE_PATH="${pkgs.glibc.dev}/include"
            '';
          };
        };
      }
    );
}
