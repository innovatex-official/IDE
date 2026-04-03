<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

**Table of Contents** _generated with [DocToc](https://github.com/thlorenz/doctoc)_

- [Running innovatex-ide using UserLAnd](#running-innovatex-ide-using-userland)
- [Running innovatex-ide using Nix-on-Droid](#running-innovatex-ide-using-nix-on-droid)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Running innovatex-ide using UserLAnd

1. Install UserLAnd from [Google Play](https://play.google.com/store/apps/details?id=tech.ula&hl=en_US&gl=US)
2. Install an Ubuntu VM
3. Start app
4. Install Node.js and `curl` using `sudo apt install nodejs npm curl -y`
5. Install `nvm`:

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
```

6. Exit the terminal using `exit` and then reopen the terminal
7. Install and use Node.js 22:

```shell
nvm install 22
nvm use 22
```

8. Install innovatex-ide globally on device with: `npm install --global innovatex-ide`
9. Run innovatex-ide with `innovatex-ide`
10. Access on localhost:8080 in your browser

# Running innovatex-ide using Nix-on-Droid

1. Install Nix-on-Droid from [F-Droid](https://f-droid.org/packages/com.termux.nix/)
2. Start app
3. Spawn a shell with innovatex-ide by running `nix-shell -p innovatex-ide`
4. Run innovatex-ide with `innovatex-ide`
5. Access on localhost:8080 in your browser
