import { runInnovateXIDECommand } from "../utils/runInnovateXIDECommand"

// NOTE@jsjoeio
// We have this test to ensure that native modules
// work as expected. If this is called on the wrong
// platform, the test will fail.
describe("--help", () => {
  it("should list innovatex-ide usage", async () => {
    const expectedOutput = "Usage: innovatex-ide [options] [path]"
    const { stdout } = await runInnovateXIDECommand(["--help"])
    expect(stdout).toMatch(expectedOutput)
  }, 20000)
})
