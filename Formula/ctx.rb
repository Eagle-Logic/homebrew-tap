class Ctx < Formula
  desc "ctx — a queryable code graph for coding agents: call graphs, blast radius, API breakage, cross-language port parity"
  homepage "https://github.com/Eagle-Logic/context"
  version "0.25.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.25.0/code-context-aarch64-apple-darwin.tar.xz"
      sha256 "44e9ca60128a96874ed19b0fe7dacb5efd790f83c580c0f660c3def9645cca33"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.25.0/code-context-x86_64-apple-darwin.tar.xz"
      sha256 "e3dc351e90ce9a57694bf8f92c776ca77cad6f5745d097c9b62a123579ccfe3e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.25.0/code-context-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "58d693c3a637f745cfdae0a3f763f50570e8bf56e8b4c3343a8e27d6e5f49439"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.25.0/code-context-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4857a8ef592d463cb579ccd020d0ca937da5784cf672302dad176fb68a2235f5"
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
