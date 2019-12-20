{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.stdenv.mkDerivation {
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
    lualatex main.tex
  '';

  installPhase = ''
    mkdir -p $out
    cp main.log $out
    cp main.pdf $out
  '';
}