class SvelteNext < Formula
  desc "Automates updating Svelte versions in project directories"
  homepage "https://github.com/shinokada/svelte-next"
  url "https://github.com/shinokada/svelte-next/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "2c0177ac9989d215f796a7f9d778e9bfffd3f530aec3cfdbaea58ffcc4de7a84"
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
