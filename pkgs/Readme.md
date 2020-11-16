# General packages

In this directory you can define Nix expressions for building general Nix packages, not specific to any package set.

All subdirectories and Nix files will be turned into toplevel Nix attributes of the same name. E.g. a directory structure like

```
./pkgs/foo/default.nix
./pkgs/bar.nix
```

allows building these packages from the root directory with

```
nix-build -A foo
nix-build -A bar
```

The Nix expressions in these files are auto-called in mostly the same way as files in nixpkgs are. That is, any nixpkgs attribute can be added to the argument list at the top to get that dependency in scope. E.g. to depend on `stdenv` and `libpng`, start the file with

```nix
{ stdenv, libpng }: ...
```

In many cases, this allows copying package files from nixpkgs directly. E.g. the [tmatrix definition from nixpkgs](https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/misc/tmatrix/default.nix) can be copied directly into `./pkgs/tmatrix/default.nix`, which can then be built with `nix-build -A tmatrix`, the same as with nixpkgs itself.

In addition, any packages from this channel take precedence over ones in nixpkgs for the passed arguments. This allows easy overriding or modification of nixpkgs packages.

For example, if we want to do modifications to the `ncurses` dependency of our defined `tmatrix`, we can copy the [ncurses definition from nixpkgs](https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/libraries/ncurses/default.nix) into `./pkgs/ncurses/default.nix`. Now the `ncurses` argument at the top of `./pkgs/tmatrix/default.nix` refers to the one defined in our channel.

It is also possible to depend on packages from other nixexprs channels, which is done by adding the `channels` argument to the argument list, and using `channels.<name>.<package>` to get a specific package from another channel. E.g. to depend on package `gpm` from channel `someChannel` (corresponding to GitHub user `someChannel`'s nixexprs repository):

```nix
{ stdenv, channels }: stdenv.mkDerivation {
  buildInputs = [
    channels.someChannel.gpm
  ];
}
```
