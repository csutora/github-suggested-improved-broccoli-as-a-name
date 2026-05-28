{
  description = "improved-broccoli - a tiny cli todo app in 10 lines of python";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});

      mkBroccoli = pkgs: pkgs.stdenv.mkDerivation {
        pname = "improved-broccoli";
        version = "0.1.0";
        src = ./.;

        nativeBuildInputs = [ pkgs.makeWrapper ];
        dontConfigure = true;
        dontBuild = true;

        installPhase = ''
          mkdir -p $out/bin $out/share/improved-broccoli
          install -m644 todo.py $out/share/improved-broccoli/todo.py
          makeWrapper ${pkgs.python3}/bin/python3 $out/bin/todo \
            --add-flags $out/share/improved-broccoli/todo.py
        '';

        meta = {
          description = "a tiny cli todo app in 10 lines of python";
          homepage = "https://github.com/csutora/github-suggested-improved-broccoli-as-a-name";
          license = pkgs.lib.licenses.mit;
          mainProgram = "todo";
          platforms = systems;
        };
      };
    in
    {
      packages = forAll (pkgs: rec {
        broccoli = mkBroccoli pkgs;
        default = broccoli;
      });

      overlays.default = final: prev: {
        broccoli = self.packages.${prev.stdenv.hostPlatform.system}.broccoli;
      };

      homeModules.default = import ./nix/home-module.nix self;
    };
}
