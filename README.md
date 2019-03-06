# invoke-and-make

Compare build tools `invoke` and `make`.

The use case is a multi-project setup, i.e. multiple projects are hosted in a single git repo. Each sub project creates it's own Docker image.

# pros and cons

make with Makefile | invoke with tasks
--- | ---
+ well known standard | + yaml as config files
+ direct shell scripts with highlighting in IDE | + Python instead of shell scripting
+ less lines of code (2/3) | + direct calling of sub-project tasks
- redundant code in each Makefile for loading properties | + clear separation of config loading from tasks file
- Makefiles are scattered around in each sub-project | .
- Shell scripts need to adopt specific $$ syntax | .
+ can run targets in parallel | parallelism not supported

# make with Makefile

runs with local environment by default
```bash
make build
```
run with specific environment
```bash
env ENVIRONMENT=development make build
```
run in parallel
```bash
make --jobs --output-sync=recurse --no-keep-going build
```
measure time for parallel run
```bash
MY_DATE=$(date); make --jobs --output-sync=recurse --no-keep-going build; echo $MY_DATE; (date)
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