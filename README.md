# invoke-and-make
Compare build tools `invoke` and `make`.

The use case is a multi-project setup, i.e. multiple projects are hosted in a single git repo. Each sub project creates it's own Docker image.

# make with Makefile

run from root (includes all sub-projects)
```bash
env ENVIRONMENT=local make build
```
run sepcific sub-project
```bash
env ENVIRONMENT=development make -C project_a build
```

# invoke with tasks

run from root (includes all sub-projects)
```bash
inv -f configs/local.yaml build
```
run sepcific sub-project
```bash
inv -f configs/local.yaml project-a.build
# or
inv -f configs/local.yaml --search-root ./tasks --collection project_a build
```

# How to use make with Makefile
For multiple commands use sub-shell
```bash
(export ENVIRONMENT=development; make build && make release)
```
or a single command in a sub-shell use `env`
```bash
env ENVIRONMENT=development make build
```

# How to use invoke
Install invoke
```bash
pip3 install --user invoke docker
```
and list all available invoke targets
```bash
inv --list
```
and execute a chain of targets
```bash
inv deploy release
```

Execute invoke with a given config file
```bash
inv -f configs/local.yaml build
# or
inv -f configs/development.yaml build
```