{
  inputs.capacitor.url = "git+ssh://git@github.com/flox/minicapacitor?ref=main&dir=capacitor&rev=2daa3287db735981dc91186232b5446b4f93e9f3";
  inputs.capacitor.inputs.root.follows = "/";

  inputs.nixpkgs-stable.url = "github:flox/nixpkgs/stable";
  inputs.nixpkgs-unstable.url = "github:flox/nixpkgs/unstable";
  inputs.nixpkgs-staging.url = "github:flox/nixpkgs/staging";
  inputs.flox-c-env.url = "path:./templates/flox-c-env";
  inputs.pkgs.url = "path:./pkgs";
  inputs.pkgs.inputs.capacitor.follows = "capacitor";

  nixConfig.bash-prompt = "[flox]\\e\[38;5;172mλ \\e\[m";

  outputs = {capacitor, ...} @ args:
    capacitor args (
      {
        lib,
        auto,
        has,
        ...
      }:
        has.stabilities
        rec {
          stable = args.nixpkgs-stable;
          unstable = args.nixpkgs-unstable;
          staging = args.nixpkgs-staging;
          default = stable;
        }
        has.systems ["x86_64-linux"]
        {
          __reflect = {
            projects = {
              pkgs = auto.callSubflake "pkgs" {};
            };
          };

          templates =
            builtins.mapAttrs
            (k: v: {
              path = v.path;
              description = (import (v.path + "/flake.nix")).description or "no description provided in ${v.path}/flake.nix";
            })
            (capacitor.lib.dirToAttrs ./templates {});
        }
    );
}
