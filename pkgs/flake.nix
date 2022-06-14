#TODO: Would be in its own repo
{
  outputs = {capacitor, ...} @ args:
    capacitor args (
      {
        lib,
        has,
        auto,
        ...
      }:
      # has.localPkgs ./.
      # has.includes { inherit (inputs) nix-installers; }
      {
        packages =
          (auto.localPkgs ./.);

        __reflect.subflakePath = "pkgs";
      }
    );
}
