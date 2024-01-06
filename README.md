# Ross's dot files

These are my settings files.
They are public for convenience of bootstrapping
and occasionally demonstrating weird hacks I'm doing to make my life work.
You're free to [copy anything](UNLICENSE) if you find it useful.

## How does this work?

My settings files are managed by [chezmoi][],
but most of the software is managed by [Nix][] (see [`flake.nix`](nix/flake.nix)).

[chezmoi]: https://www.chezmoi.io/
[Nix]: https://nixos.org/

### Why not use [home-manager][]?

While I very much like Nix,
my primary dev machines run Windows (upon which I run WSL),
so I need a cross-platform solution to manage my files.

[home-manager]: https://github.com/nix-community/home-manager

## New Machine Instructions

First, I download the decryption key if I need it:

```shell
eval $(op signin) &&
op document get 5gempl6hrjpndby7gbtjax3qom --output ~/dotfiles-agekey.txt
```

Then I run:

```shell
sh -c "$(curl -fsSL git.io/chezmoi)" -- init --apply zombiezen
```

## Using the flake

My scripts are [bundled with Nix][],
so you can run them
and they're guaranteed to work in the same way as they do on my machines.
To see a list of packages I'm using:

```shell
nix flake show 'github:zombiezen/dotfiles?dir=nix'
```

To run one:

```shell
nix run 'github:zombiezen/dotfiles?dir=nix#nix-op-key'
```

[bundled with Nix]: https://www.zombiezen.com/blog/2023/12/bundling-scripts-nix/
