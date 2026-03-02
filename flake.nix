{
  description = "Manual duplex printing script";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        runtimeDeps = [ pkgs.pdftk pkgs.cups ];
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "duplex";
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          buildInputs = runtimeDeps;

          installPhase = ''
            mkdir -p $out/bin
            mkdir -p $out/share/man/man1

            cp duplex $out/bin/duplex
            chmod +x $out/bin/duplex

            cp duplex.1 $out/share/man/man1/duplex.1

            wrapProgram $out/bin/duplex \
              --prefix PATH : ${pkgs.lib.makeBinPath runtimeDeps}
          '';

          meta = with pkgs.lib; {
            description = "Manual duplex printing script";
            license = licenses.cc0;
            platforms = platforms.unix;
            mainProgram = "duplex";
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = runtimeDeps;
        };
      }
    );
}
