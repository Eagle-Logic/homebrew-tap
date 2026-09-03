class Ctx < Formula
  desc "ctx — a queryable code graph for coding agents: call graphs, blast radius, API breakage, cross-language port parity"
  homepage "https://github.com/Eagle-Logic/context"
  version "0.22.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.22.1/code-context-aarch64-apple-darwin.tar.xz"
      sha256 "8f1870636c0ebfe5706095414d3a48bbc288849877d6cc62f9763a3a1cc902c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.22.1/code-context-x86_64-apple-darwin.tar.xz"
      sha256 "3a780b3480ebd5206b5d705e705c1146a1b760c9c6a406a8ae3d301a805c0308"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.22.1/code-context-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eb2096ffc5951d115f563b704c90098c37a67d39c967d98268b113d7fbb765ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.22.1/code-context-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c464fe8f5ba56721900b11fcab4af70c64d4f4ce25cf07205cb79bf2f190440c"
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
