{
  description = "";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs;
    utils.url = github:numtide/flake-utils;
  };

  outputs = inputs@{ self, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        name = "template";
        version = "0.1.0";

        pkgs.nix = inputs.nixpkgs.legacyPackages.${system};
        stdenv = pkgs.nix.llvmPackages_13.stdenv;
        mkShell = pkgs.nix.mkShell.override { inherit stdenv; };

        packages.${name} = stdenv.mkDerivation {
          inherit version;
          pname = name;

          src = ./.;
          
          nativeBuildInputs = with pkgs.nix; [
            meson
            ninja
            pkg-config
          ];

          buildInputs = with pkgs.nix; [
            fmt
          ];

          hardeningEnable = [ "pie" ];
          mesonBuildType = "release";
        };

      in {
        inherit packages;
        defaultPackage = packages.${name};

        devShell = mkShell {
          hardeningDisable = [ "all" ];
          packages = with pkgs.nix; [
            fmt
            meson
            ninja
            pkg-config
          ];
        };
      }
    );
}
