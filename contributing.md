# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test wren-cli https://github.com/jtakakura/asdf-wren-cli.git "wren_cli --help"
```

Tests are automatically run in GitHub Actions on push and PR.
