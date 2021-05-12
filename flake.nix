{
  inputs = {
    naersk = {
      type = "git";
      url = "https://github.com/yusdacra/naersk.git?ref=feat%2Fcargolock-git-deps&rev=07d0b56bdbd353a705f26b799e3a125c7be0f8c3";
      rev = "07d0b56bdbd353a705f26b799e3a125c7be0f8c3";
      ref = "feat/cargolock-git-deps";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url =  github:numtide/flake-utils;
  };

  outputs = { self, naersk, nixpkgs, utils }:
  utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
    let
      pkgs = import nixpkgs { inherit system; };
      naersk-lib = pkgs.callPackage naersk {};
      nativeBuildInputs = with pkgs; [ pkg-config makeWrapper clang_11 ];
      buildInputs = with pkgs; [ llvmPackages_11.libclang ];
        # tflite crate needs libclang
        LIBCLANG_PATH = "${pkgs.llvmPackages_11.libclang}/lib";
    in {
      defaultPackage = naersk-lib.buildPackage {
        root = ./.;
        src = ./.;

        inherit nativeBuildInputs buildInputs LIBCLANG_PATH;

        doCheck = true;
        gitSubmodules = true;
      };

      devShell = pkgs.mkShell {
        inherit buildInputs LIBCLANG_PATH;
        nativeBuildInputs = nativeBuildInputs ++ [ pkgs.rustc pkgs.cargo ];
      };
    });
}
