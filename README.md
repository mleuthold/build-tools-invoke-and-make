# invoke-and-make
Compare build tools invoke and make

# How to use make
For multiple commands use sub-shell
```bash
(export ENVIRONMENT=development; make build && make release)
```
or a single command in a sub-shell with `env`
```bash
env ENVIRONMENT=development make build
```