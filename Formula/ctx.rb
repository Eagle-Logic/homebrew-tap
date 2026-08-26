class Ctx < Formula
  desc "ctx — a queryable code graph for coding agents: call graphs, blast radius, API breakage, cross-language port parity"
  homepage "https://github.com/Eagle-Logic/context"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.20.0/code-context-aarch64-apple-darwin.tar.xz"
      sha256 "f51e062cf3aa24f1e7930bf6f45d67946d2ce7d48dbf9ab2b77dc4004ad316e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.20.0/code-context-x86_64-apple-darwin.tar.xz"
      sha256 "63cf73a50aab49d00434ba6ad0291854b6110a7210f5ff66575fe14cb7ea8d7e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.20.0/code-context-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09fcdbc4cdf321f6707555306cf9d6b1499c984b0d94f258af9cb7272bb26ae3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.20.0/code-context-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "07f0c4a2dca6e40ae07ac7071c6b8aab83dcf9f4e11ac981c13e8cd212b7c360"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ctx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ctx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ctx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ctx"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
