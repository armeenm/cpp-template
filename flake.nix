{
  description = "";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs;
    utils.url = github:numtide/flake-utils;
  };

  outputs = inputs@{ self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        name = "template";
        version = "0.1.0";

        pkgs = nixpkgs.legacyPackages.${system};

        stdenv = pkgs.llvmPackages_13.stdenv;

        mkShell = pkgs.mkShell.override { inherit stdenv; };

      in rec {
        packages.${name} = stdenv.mkDerivation {
          inherit version;
          pname = name;

          src = ./.;
          
          nativeBuildInputs = with pkgs; [
            meson
            ninja
            pkg-config
            stdenv.cc
          ];

          buildInputs = with pkgs; [
            fmt
          ];

          hardeningEnable = [ "pie" ];
          mesonBuildType = "release";
        };

        defaultPackage = packages.${name};

        devShell = mkShell {
          hardeningDisable = [ "all" ];
          packages = with pkgs; [
            fmt
            llvmPackages_13.clang
            meson
            ninja
            pkg-config
            stdenv.cc
          ];
        };
      }
    );
}
