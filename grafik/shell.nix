{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    inkscape
    optipng
    imagemagick
    libicns
    libreoffice
    ed
    libxkbcommon
    python3
    python3Packages.pandas
    python3Packages.matplotlib
    python3Packages.seaborn
    python3Packages.more-itertools
    python3Packages.jinja2
    perl
    perlPackages.XMLWriter
    php
  ];

  # You also need to install the fonts (libertine gentium dejavu ... )
}
