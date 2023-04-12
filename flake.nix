{
  description = "Floxpkgs/Project Template";
  inputs.flox-floxpkgs.url = "github:flox/floxpkgs";

  # Declaration of external resources
  # =================================

  # An example import of a "capacitated" project
  /*
  inputs.my-project.url = "github:me/myproject";
  */

  # =================================

  outputs = args @ {flox-floxpkgs, ...}:
    flox-floxpkgs.project args (context: {
      # explicit package definitions
      # the format is equivalent to package definitions in
      # `./pkgs/my-pkg/default.nix`
      packages = {
        # explicit packages allow re-exports of single packages
        # from package sets that can't be accessed by all users of this project
        #
        # Note: re-exporting generally provides less guarantees
        #       than importing a package set in terms of composability.
        #       `config.projects` should be used preferably, if possible.
        #
        # Note: if re-export comes from a capacitated flake,
        #       use `context.capacitated` over `context.inputs`
        #       to ensure coherent dependencies.
        /*
        ext-pkg = context: context.capacitated.my-project.packages.ext-pkg;
        */
      };

      config = {
        # by default all packages defined in this flake will be buildable on
        # the four most common platforms.
        # `config.settings` allows additional systems to be configured
        # by overriding the default set
        /*
        systems = [
          "aarch64-darwin"
          "aarch64-linux"
          "x86_64-darwin"
          "x86_64-linux"
        ];
        */

        nixpkgs-config = {
          # Unfree licenses are disallowed by default
          # but can be enabled on a per-project basis.
          #
          # If an unfree package is imported by one of your packages,
          # trying to build the package will raise an error like:
          #
          #   Package 'slack-4.29.149' in /nix/store/... has an unfree license
          #   ('unfree'), refusing to evaluate.
          #
          # The configuration below shows how to permit the usage of "slack"
          # or other tools that run into this problem.
          #
          # Note: the configuration only applies to the current project
          #       and overrides the config in projects.
          #       It also affects only packages when accessed through the
          #       `context` - either in a package definition
          #       or `context.nixpkgs.slack`.
          /*
          allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
            "slack"
          ];
          */

          # `config.projects` can be used to compose capacitated  package sets.
          # All packages defined in the imported projects will be merged
          # and become available in the `context` of this flake.
          #
          # Note: composing package sets may require rebuilding some packages
          #       as some dependency versions may differ
          #       from one package set to another.
          #       composing such package sets ensures a single coherent set.
          projects = {
            /*
            inherit (context.capacitated) my-project;
            */
          };

          # If a package is already defined by an imported project
          # (see `config.projects`) an error will be thrown asking to rename
          # the local package or ensure that it is compatible
          # with the existing package.
          # If you choose to attest its compatibility,
          # add the name of the package here, as instructed at build time.
          checkedExtensions = [
            /*
            "some-package"
            */
          ];
        };
      };
    });
}
