class SvelteNext < Formula
  desc "Automates updating Svelte versions in project directories"
  homepage "https://github.com/shinokada/svelte-next"
  url "https://github.com/shinokada/svelte-next/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "de65e5ef2f1f464b320dc79af129b2e18d9eb1207af825c73c55474050306b37"
  license "MIT"

  def install
    # Install the main script and all supporting files into libexec.
    # lib/ and src/ cannot live next to the bin/ wrapper, so we set
    # SVELTE_NEXT_LIBEXEC to tell _find_script_dir() exactly where they are.
    libexec.install "svelte-next", "lib", "src"

    # Thin wrapper in bin/ — the only thing that goes on PATH.
    # Sets SVELTE_NEXT_LIBEXEC so _find_script_dir() picks it up as
    # candidate 1 and skips filesystem probing entirely.
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
