{ pkgs ? import <nixpkgs> {}, ... }:

let
  userSecrets = import ./userSecrets.nix;
in
  pkgs.stdenv.mkDerivation({
    name = "agondek-cv";
    src = ./.;

    buildInputs = with pkgs; [ 
      (texlive.combine {
        inherit (texlive)
          scheme-medium
          fontawesome
          geometry
          hyperref
          moresize
          raleway;
      })
    ];

    buildPhase = ''
      # See: https://tex.stackexchange.com/questions/496275/texlive-2019-lualatex-doesnt-compile-document
      # Without export, lualatex fails silently, with exit code '0'
      export TEXMFVAR=$(pwd)
      lualatex -interaction=nonstopmode agondek-cv.tex
    '';

    installPhase = ''
      mkdir -p $out
      cp agondek-cv.log $out
      cp agondek-cv.pdf $out
    '';
  } // userSecrets)
