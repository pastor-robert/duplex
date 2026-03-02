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
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "duplex";
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          buildInputs = [ pkgs.pdftk ];

          installPhase = ''
            mkdir -p $out/bin
            cp duplex $out/bin/duplex
            chmod +x $out/bin/duplex
            wrapProgram $out/bin/duplex \
              --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.pdftk ]}
          '';

          meta = with pkgs.lib; {
            description = "Manual duplex printing script";
            license = licenses.cc0;
            platforms = platforms.unix;
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.pdftk ];
        };
      }
    );
}
