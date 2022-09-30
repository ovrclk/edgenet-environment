# Setup edgenet environment

## Prerequisites
### Direnv
This tutorial heavily depends on `direnv`. Skip this section if you have it installed and configured

#### Install
##### MacOS
```shell
brew install direnv
```

##### Debian/Ubuntu based distributes
```shell
sudo apt-get update
sudo apt-get install -y direnv
```

##### Arch Linux
```shell
sudo pacman -Rcns direnv
```

#### Hook it to the shell
Detect your shell
```
echo "$SHELL"
```
##### bash
```shell
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
```
##### zsh
```shell
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
```

##### fish
```shell
echo '>direnv hook fish | source' >> ~/.config/fish/config.fish
```

##### tcsh
```shell
echo 'eval `direnv hook tcsh`' >> ~/.cshrc 
```

!!! Reload shell after hook installation

### Make
Tutorial requires `make` to be installed on your system

## How to use it

### Clone repo
```shell
git clone https://github.com/ovrclk/edgenet-environment.git
cd edgenet-environment
```

### Allow direnv
Run following command to permit direnv. it needs to be done just once (see #updating-environment)
This will automatically set up all required directories, download binaries and update PATH

```
direnv allow
```

### Using

Both `akash` and `provider-services` binaries will be available in `edgenet-environment` directory. Don't need to put current path prefix `./`to execute them. For example
```shell
akash version
```

it will execute `akash` binary located in `.cache/bin`. Same applies to the `provider-services`

#### Updating environment

`.env` file can be edited with extra environment variable like `AKASH_NODE` etc.
Each update will prompt to run `direnv allow`

#### Adding keys
!!!Upon first call to direnv it will generate default key `test`

Use `akash` executable ONLY to manage keys. For example
```shell
akash keys add test
```

#### Creating deployments

Use `provider-services` to create deployment and lease transactions as well as sending manifest and checking lease status

```shell
provider-services tx deployment create <your deployment.yaml> --from=test
provider-services tx lease-create ...
provider-services send-manifest <your deployment.yaml> --from=test
```

