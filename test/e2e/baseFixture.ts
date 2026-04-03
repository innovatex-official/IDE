import { test as base } from "@playwright/test"
import { InnovateXIDE, InnovateXIDEPage } from "./models/InnovateXIDE"

/**
 * Wraps `test.describe` to create and manage an instance of innovatex-ide. If you
 * don't use this you will need to create your own innovatex-ide instance and pass
 * it to `test.use`.
 *
 * If `includeCredentials` is `true` page requests will be authenticated.
 */
export const describe = (
  name: string,
  codeServerArgs: string[],
  codeServerEnv: NodeJS.ProcessEnv,
  fn: (codeServer: InnovateXIDE) => void,
) => {
  test.describe(name, () => {
    // This will spawn on demand so nothing is necessary on before.
    const codeServer = new InnovateXIDE(name, codeServerArgs, codeServerEnv, undefined)

    // Kill innovatex-ide after the suite has ended. This may happen even without
    // doing it explicitly but it seems prudent to be sure.
    test.afterAll(async () => {
      await codeServer.close()
    })

    test.use({
      // Makes `codeServer` and `authenticated` available to the extend call
      // below.
      codeServer,
      // NOTE@jsjoeio some tests use --cert which uses a self-signed certificate
      // without this option, those tests will fail.
      ignoreHTTPSErrors: true,
    })

    fn(codeServer)
  })
}

interface TestFixtures {
  codeServer: InnovateXIDE
  codeServerPage: InnovateXIDEPage
}

/**
 * Create a test that spawns innovatex-ide if necessary and ensures the page is
 * ready.
 */
export const test = base.extend<TestFixtures>({
  codeServer: undefined, // No default; should be provided through `test.use`.
  codeServerPage: async ({ codeServer, page }, use) => {
    // It's possible innovatex-ide might prevent navigation because of unsaved
    // changes (seems to happen based on timing even if no changes have been
    // made too). In these cases just accept.
    page.on("dialog", (d) => d.accept())

    const codeServerPage = new InnovateXIDEPage(codeServer, page)
    await codeServerPage.navigate()
    await use(codeServerPage)
  },
})

/** Shorthand for test.expect. */
export const expect = test.expect
