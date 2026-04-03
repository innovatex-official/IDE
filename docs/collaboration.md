<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

**Table of Contents** _generated with [DocToc](https://github.com/thlorenz/doctoc)_

- [Collaboration](#collaboration)
  - [Code sharing using Duckly](#code-sharing-using-duckly)
    - [Installing the Duckly Extension](#installing-the-duckly-extension)
    - [Sharing with Duckly](#sharing-with-duckly)
  - [Code sharing using CodeTogether](#code-sharing-using-codetogether)
    - [Installing the CodeTogether extension](#installing-the-codetogether-extension)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Collaboration

With third-party extensions, you can use innovatex-ide to collaborate with other developers in real time.

## Code sharing using Duckly

[Duckly](https://duckly.com/) allows you to share your code in real-time even with people using different IDEs (like JetBrains and VSCode).

- Cross-IDE support,
- Real-time typing,
- P2P encrypted,
- Voice and audio chat,
- Terminal sharing

### Installing the Duckly Extension

Duckly uses an extension to provide real time sharing features

1. Install the Duckly extension from OpenVSX on `innovatex-ide`.

```bash
SERVICE_URL=https://open-vsx.org/vscode/gallery \
  ITEM_URL=https://open-vsx.org/vscode/item \
  innovatex-ide --install-extension gitduck.code-streaming
```

2. Refresh you `innovatex-ide` window. You should now be able to see the Duckly extension.

### Sharing with Duckly

As `innovatex-ide` is based on VS Code, you can follow the steps described on Duckly's [Pair programming with VS Code](https://duckly.com/tools/vscode) page and skip the installation step.

## Code sharing using CodeTogether

[CodeTogether](https://www.codetogether.com/) is a real-time cross-IDE replacement for Microsoft Live Share providing:

- Cross-IDE support - between VS Code, Eclipse, IntelliJ and IDEs based on them (browser or desktop)
- Real-time editing - shared or individual cursors for pairing, mobbing, swarming, or whatever
- P2P encrypted - servers can't decrypt the traffic ([Security Details](https://codetogether.com/download/security/))
- SaaS or [On-premises](https://codetogether.com/on-premises/) options
- Shared servers, terminals, and consoles
- Unit Testing - with support for Red, Green, Refactor TDD
- Joining via a web browser or your preferred IDE
- Free unlimited 1 hour sessions with 4 participants
- Multiple plans including [free or paid options](https://www.codetogether.com/pricing/)

### Installing the CodeTogether extension

1. Install the CodeTogether extension from OpenVSX on `innovatex-ide`.

   ```sh
   SERVICE_URL=https://open-vsx.org/vscode/gallery \
     ITEM_URL=https://open-vsx.org/vscode/item \
     innovatex-ide --install-extension genuitecllc.codetogether
   ```

2. CodeTogether requires VS Code's proposed API to run. Start innovatex-ide with the following flag:

   ```sh
   innovatex-ide --enable-proposed-api genuitecllc.codetogether
   ```

   Another option would be to add a value in innovatex-ide's [config file](https://github.com/innovatex-official/IDE/docs/innovatex-ide/latest/FAQ#how-does-the-config-file-work).

3. Refresh innovatex-ide and navigate to the CodeTogether icon in the sidebar to host or join a coding session.
