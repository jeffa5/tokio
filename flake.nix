{
  description = "Exploring tokio";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    crate2nix.url = "github:jeffa5/crate2nix";
  };

  outputs = {
    self,
    nixpkgs,
    crate2nix,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    formatter.${system} = pkgs.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs;
        [
          rustc
          rustfmt
          cargo
          clippy
        ]
        ++ [crate2nix.packages.${system}.crate2nix];
    };
  };
}
