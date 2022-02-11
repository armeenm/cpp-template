{
  description = "";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    utils.url = github:numtide/flake-utils;
  };

  outputs = inputs@{ self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        name = "template";
        version = "0.1.0";

        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;

      in rec {
        packages.${name} = pkgs.stdenv.mkDerivation {
          inherit name version;

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

          mesonBuildType = "release";
        };

        defaultPackage = packages.${name};

        devShell = pkgs.mkShell {
          packages = with pkgs; [
            clang
            fmt
            meson
            ninja
            pkg-config
            stdenv.cc
          ];
        };
      }
    );
}
