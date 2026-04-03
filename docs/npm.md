<!-- prettier-ignore-start -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# npm Install Requirements

- [Node.js version](#nodejs-version)
- [Ubuntu, Debian](#ubuntu-debian)
- [Fedora, CentOS, RHEL](#fedora-centos-rhel)
- [Alpine](#alpine)
- [macOS](#macos)
- [FreeBSD](#freebsd)
- [Windows](#windows)
- [Installing](#installing)
- [Troubleshooting](#troubleshooting)
  - [Issues with Node.js after version upgrades](#issues-with-nodejs-after-version-upgrades)
  - [Debugging install issues with npm](#debugging-install-issues-with-npm)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->
<!-- prettier-ignore-end -->

If you're installing innovatex-ide via `npm`, you'll need to install additional
dependencies required to build the native modules used by VS Code. This article
includes installing instructions based on your operating system.

> **WARNING**: Do not use `yarn` to install innovatex-ide. Unlike `npm`, it does not respect
> lockfiles for distributed applications. It will instead use the latest version
> available at installation time - which might not be the one used for a given
> innovatex-ide release, and [might lead to unexpected behavior](https://github.com/innovatex/innovatex-ide/issues/4927).

## Node.js version

We use the same major version of Node.js shipped with Code's remote, which is
currently `22.x`. VS Code also [lists Node.js
requirements](https://github.com/microsoft/vscode/wiki/How-to-Contribute#prerequisites).

Using other versions of Node.js [may lead to unexpected
behavior](https://github.com/innovatex/innovatex-ide/issues/1633).

## Ubuntu, Debian

```bash
sudo apt-get install -y \
  build-essential \
  pkg-config \
  python3
npm config set python python3
```

Proceed to [installing](#installing)

## Fedora, CentOS, RHEL

```bash
sudo yum groupinstall -y 'Development Tools'
sudo yum config-manager --set-enabled PowerTools # unnecessary on CentOS 7
sudo yum install -y python2
npm config set python python2
```

Proceed to [installing](#installing)

## Alpine

```bash
apk add alpine-sdk bash libstdc++ libc6-compat python3 krb5-dev
```

Proceed to [installing](#installing)

## macOS

```bash
xcode-select --install
```

Proceed to [installing](#installing)

## FreeBSD

```sh
pkg install -y git python npm-node22 pkgconf
pkg install -y libinotify
```

Proceed to [installing](#installing)

## Windows

Installing innovatex-ide requires all of the [prerequisites for VS Code development](https://github.com/Microsoft/vscode/wiki/How-to-Contribute#prerequisites). When installing the C++ compiler tool chain, we recommend using "Option 2: Visual Studio 2019" for best results.

Next, install innovatex-ide with:

```bash
npm install --global innovatex-ide
innovatex-ide
# Now visit http://127.0.0.1:8080. Your password is in ~/.config/innovatex-ide/config.yaml
```

A `postinstall.sh` script will attempt to run. Select your terminal (e.g., Git bash) as the default shell for npm run-scripts. If an additional dialog does not appear, run the install command again.

If the `innovatex-ide` command is not found, you'll need to [add a directory to your PATH](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/). To find the directory, use the following command:

```shell
npm config get prefix
```

For help and additional troubleshooting, see [#1397](https://github.com/innovatex/innovatex-ide/issues/1397).

## Installing

After adding the dependencies for your OS, install the innovatex-ide package globally:

```bash
npm install --global innovatex-ide
innovatex-ide
# Now visit http://127.0.0.1:8080. Your password is in ~/.config/innovatex-ide/config.yaml
```

## Troubleshooting

If you need further assistance, post on our [GitHub Discussions
page](https://github.com/innovatex/innovatex-ide/discussions).

### Issues with Node.js after version upgrades

Occasionally, you may run into issues with Node.js.

If you install innovatex-ide using `npm`, and you upgrade your Node.js
version, you may need to reinstall innovatex-ide to recompile native modules.
Sometimes, you can get around this by navigating into innovatex-ide's `lib/vscode`
directory and running `npm rebuild` to recompile the modules.

A step-by-step example of how you might do this is:

1. Install innovatex-ide: `brew install innovatex-ide`
2. Navigate into the directory: `cd /usr/local/Cellar/innovatex-ide/<version>/libexec/lib/vscode/`
3. Recompile the native modules: `npm rebuild`
4. Restart innovatex-ide

### Debugging install issues with npm

To debug installation issues, install with `npm`:

```shell
# Uninstall
npm uninstall --global innovatex-ide > /dev/null 2>&1

# Install with logging
npm install --loglevel verbose --global innovatex-ide
```
