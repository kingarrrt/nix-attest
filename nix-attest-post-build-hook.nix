{
  lib,
  bash,
  coreutils,
  jq,
  nix,
  resholve,
  util-linux,
}:
let
  pname = "nix-attest-post-build-hook";
in
resholve.mkDerivation {
  inherit pname;
  version = "git";
  src = ./nix-attest-post-build-hook;
  unpackPhase = ''
    cp ${./nix-attest-post-build-hook} ${pname}
  '';
  installPhase = ''
    install -D --target-directory=$out/bin ${pname}
  '';
  solutions = {
    bash = {
      interpreter = lib.getExe bash;
      inputs = [
        coreutils
        jq
        nix
        util-linux
      ];
      execer = [ "cannot:${lib.getExe nix}" ];
      scripts = [ "bin/${pname}" ];
    };
  };
}
