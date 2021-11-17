{
  description = "";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    utils.url = github:numtide/flake-utils;
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        name = "template";

        pkgs = import nixpkgs {
          inherit system;
        };
        lib = pkgs.lib;

      in rec {
        packages.${name} = pkgs.stdenv.mkDerivation {
          pname = name;
          version = "0.1.0";
          src = ./.;
          
          nativeBuildInputs = with pkgs; [
            meson
            ninja
            cmake
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
            cmake
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
