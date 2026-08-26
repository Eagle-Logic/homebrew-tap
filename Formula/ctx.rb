class Ctx < Formula
  desc "ctx — a queryable code graph for coding agents: call graphs, blast radius, API breakage, cross-language port parity"
  homepage "https://github.com/Eagle-Logic/context"
  version "0.18.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.18.0/code-context-aarch64-apple-darwin.tar.xz"
      sha256 "f4fb74948445019efa38325effdc9150951f2dbc478d440efeef2d4790ab3c50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.18.0/code-context-x86_64-apple-darwin.tar.xz"
      sha256 "635b83de6aa1b51e8ea30e45efc06ed259ee6358bdfaa732435e1f5b325a4001"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.18.0/code-context-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f77b53ced379a9b352a2fd8421b6e9add79eae6270a6afe917302f5426ca97e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.18.0/code-context-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e9c48e7a4847e5e8370684c94fa082c293e6a8ff432d98faa79be0267dda7937"
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
