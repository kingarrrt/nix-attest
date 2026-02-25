{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs =
    inputs:
    let
      inherit (inputs) nixpkgs;
      inherit (nixpkgs) lib;
    in
    {
      packages = lib.genAttrs lib.systems.flakeExposed (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.callPackage ./nix-attest-post-build-hook.nix { };
        }
      );
    };
}
