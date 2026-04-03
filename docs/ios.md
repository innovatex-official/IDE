# Using innovatex-ide on iOS with iSH

1. Install iSH from the [App Store](https://apps.apple.com/us/app/ish-shell/id1436902243)
2. Install `curl` and `nano` with `apk add curl nano`
3. Configure iSH to use an earlier version of NodeJS with `nano /etc/apk/repositories` and edit `v3.14` to `v3.12` on both repository links.
4. Install `nodejs` and `npm` with `apk add nodejs npm`
5. Install innovatex-ide with `curl -fsSL https://github.com/innovatex-official/IDE/install.sh | sh`
6. Run innovatex-ide with `innovatex-ide`
7. Access on localhost:8080 in your browser
