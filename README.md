# Setup edgenet environment

## Prerequisites
### Direnv
This tutorial heavily depends on `direnv`. If it is unfamiliar to you check out [installations page](https://direnv.net/docs/installation.html) on how to set it up

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

