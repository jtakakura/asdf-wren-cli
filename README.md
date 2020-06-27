<div align="center">

# asdf-wren-cli ![Build](https://github.com/jtakakura/asdf-wren-cli/workflows/Build/badge.svg) ![Lint](https://github.com/jtakakura/asdf-wren-cli/workflows/Lint/badge.svg)

[wren-cli](https://wren.io/cli) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- Make sure you have the required dependencies installed:
  - curl
  - unzip

# Install

Plugin:

```shell
asdf plugin add wren-cli
# or
asdf plugin add https://github.com/jtakakura/asdf-wren-cli.git
```

wren-cli:

```shell
# Show all installable versions
asdf list-all wren-cli

# Install specific version
asdf install wren-cli latest

# Set a version globally (on your ~/.tool-versions file)
asdf global wren-cli latest

# Now wren-cli commands are available
wren_cli --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/jtakakura/asdf-wren-cli/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Junji Takakura](https://github.com/jtakakura/)
