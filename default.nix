{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
  name = "agondek-cv";
  src = ./.;

  buildInputs = with pkgs; [ 
    texlive.combined.scheme-medium
  ];

  buildPhase = ''
    # See: https://tex.stackexchange.com/questions/496275/texlive-2019-lualatex-doesnt-compile-document
    # Without export, lualatex fails silently, with exit code '0'
    export TEXMFVAR=$(pwd)
    lualatex agondek-cv.tex
  '';

  installPhase = ''
    mkdir -p $out
    cp agondek-cv.log $out
    cp agondek-cv.pdf $out
  '';
}