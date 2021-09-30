# Ross's dot files

These are my settings files, managed by [chezmoi][].

[chezmoi]: https://www.chezmoi.io/

## New Machine Instructions

First, I download the decryption key if I need it:

```shell
eval $(op signin my.1password.com) &&
op get document 5gempl6hrjpndby7gbtjax3qom --output dotfiles-agekey.txt
```

Then I run:

```shell
sh -c "$(curl -fsSL git.io/chezmoi)" -- init --apply zombiezen
```
