class SvelteNext < Formula
  desc "Automates updating Svelte versions in project directories"
  homepage "https://github.com/shinokada/svelte-next"
  version "0.5.2"
  url "https://github.com/shinokada/svelte-next/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "2c0177ac9989d215f796a7f9d778e9bfffd3f530aec3cfdbaea58ffcc4de7a84"
  license "MIT"

  def install
    # Install the main script and all supporting files into libexec
    # so they stay together and script_dir resolves correctly
    libexec.install "svelte-next", "lib", "src"

    # Write a thin wrapper in bin/ that sets SVELTE_NEXT_LIBEXEC so the
    # script does not need to resolve symlinks to find lib/ and src/
    (bin/"svelte-next").write <<~EOS
      #!/usr/bin/env bash
      export SVELTE_NEXT_LIBEXEC="#{libexec}"
      exec "#{libexec}/svelte-next" "$@"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/svelte-next --version")
  end
end
