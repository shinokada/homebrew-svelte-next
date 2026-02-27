class SvelteNext < Formula
  desc "Automates updating Svelte versions in project directories"
  homepage "https://github.com/shinokada/svelte-next"
  version "0.5.2"
  url "https://github.com/shinokada/svelte-next/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "2c0177ac9989d215f796a7f9d778e9bfffd3f530aec3cfdbaea58ffcc4de7a84"
  license "MIT"

  def install
    bin.install "svelte-next"
    prefix.install "lib", "src"
  end

  test do
    assert_match "version", shell_output("#{bin}/svelte-next --version")
  end
end