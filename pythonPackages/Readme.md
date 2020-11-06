# Python packages

In this directory you can define Nix expressions for building python packages.

All subdirectories and Nix files will be turned into Nix attributes under `python*Packages`. E.g. a structure like

```
./pythonPackages/foo/default.nix
./pythonPackages/bar.nix
```

allows building these packages from the root directory with

```
nix-build -A pythonPackages.foo
nix-build -A pythonPackages.bar
```

While `pythonPackages` provides access to the package set for the default python version (currently 2.7), you can also build packages for other versions:

```
nix-build -A python37Packages.foo
nix-build -A python38Packages.foo
```

All python versions from nixpkgs are supported.

The Nix expressions in these files are auto-called in mostly the same way as python packages in nixpkgs are. That is, any nixpkgs attribute or python package can be added to the argument list at the top to get that dependency in scope. E.g. to depend on `stdenv` and the python package `requests`, start the file with

```nix
{ stdenv, requests }: ...
```

In many cases, this allows copying package files from nixpkgs directly. E.g. the [`black` definition from nixpkgs](https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/python-modules/black/default.nix) can be copied directly into `./pythonPackages/black/default.nix`, which can then be built with `nix-build -A python3Packages.black`, the same as with nixpkgs itself.

In addition, any packages from this channel take precedence over ones in nixpkgs for the passed arguments. This allows easy overriding or modification of nixpkgs packages.

For example, if we want to do modifications to the `typed-ast` python dependency of our defined `black`, we can copy the [`typed-ast` definition from nixpkgs](https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/python-modules/typed-ast/default.nix) into `./pythonPackages/typed-ast/default.nix`. Now the `typed-ast` argument at the top of `./pythonPackages/black/default.nix` refers to the one defined in our channel.

It is also possible to depend on packages from other nixexprs channels, which is done by adding the `channels` argument to the argument list, and using `channels.<name>.<package>` to get a specific package from another channel. For python packages, use `channels.<name>.pythonPackages.<package>`. E.g. to depend on python package `pathspec` from channel `someChannel` (corresponding to GitHub user `someChannel`'s nixexprs repository):

```nix
{ buildPythonPackage, channels }: buildPythonPackage {
  propagatedBuildInputs = [
    channels.someChannel.pythonPackages.pathspec
  ];
}
```

## Resolving package conflicts

It can easily happen for a package conflict to occur. E.g. if the above example is extended to mirror nixpkgs python package `toml` with some modifications into `./pythonPackages/toml/default.nix`, building `python3Packages.black` will fail with

```
pythonCatchConflictsPhase
Found duplicated packages in closure for dependency 'toml':
  toml 0.10.1 (/nix/store/3an149y1zwr2a2m0b2imzd097xyqh03g-python3.8-toml-0.10.1/lib/python3.8/site-packages)
  toml 0.10.1 (/nix/store/gpl2anl6b6qj43h27pwdg0ip856nbyh0-python3.8-toml-0.10.1/lib/python3.8/site-packages)

Package duplicates found in closure, see above. Usually this happens if two packages depend on different version of the same dependency.
builder for '/nix/store/6nc56ahrw35vpx96jbywb9s26rv66v08-python3.8-black-19.10b0.drv' failed with exit code 1
```

TODO: How to resolve this
