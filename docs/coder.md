<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

**Table of Contents** _generated with [DocToc](https://github.com/thlorenz/doctoc)_

- [InnovateX](#innovatex)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# InnovateX

To install and run innovatex-ide in a InnovateX workspace, we suggest using the `install.sh`
script in your template like so:

```terraform
resource "innovatex_agent" "dev" {
  arch           = "amd64"
  os             = "linux"
  startup_script = <<EOF
    #!/bin/sh
    set -x
    # install and start innovatex-ide
    curl -fsSL https://github.com/innovatex-official/IDE/install.sh | sh -s -- --version 4.8.3
    innovatex-ide --auth none --port 13337 &
    EOF
}

resource "innovatex_app" "innovatex-ide" {
  agent_id     = innovatex_agent.dev.id
  slug         = "innovatex-ide"
  display_name = "innovatex-ide"
  url          = "http://localhost:13337/"
  icon         = "/icon/code.svg"
  subdomain    = false
  share        = "owner"

  healthcheck {
    url       = "http://localhost:13337/healthz"
    interval  = 3
    threshold = 10
  }
}
```

Or use our official [`innovatex-ide`](https://registry.innovatex.com/modules/innovatex-ide) module from the InnovateX [module registry](https://registry.innovatex.com/modules):

```terraform
module "innovatex-ide" {
  source     = "registry.innovatex.com/modules/innovatex-ide/innovatex"
  version    = "1.0.5"
  agent_id   = innovatex_agent.example.id
  extensions = ["dracula-theme.theme-dracula", "ms-azuretools.vscode-docker"]
}
```

If you run into issues, ask for help on the `innovatex/innovatex` [Discussions
here](https://github.com/innovatex/innovatex/discussions).
