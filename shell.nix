{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  name = "double-dash-shell";

  packages = with pkgs; [
    godot
  ];
}
