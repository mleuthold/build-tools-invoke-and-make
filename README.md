# invoke-and-make
Compare build tools invoke and make

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
pip3 install --user invoke
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