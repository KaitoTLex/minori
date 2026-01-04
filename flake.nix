{
  description = "SystemVerilog development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "systemverilog-dev";

          packages = with pkgs; [
            verilator
            iverilog
            yosys
            svlint
            gtkwave

            # Editor / tooling support
            clang-tools
            pkg-config
          ];
        };
      }
    );
}
