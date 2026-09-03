class Ctx < Formula
  desc "ctx — a queryable code graph for coding agents: call graphs, blast radius, API breakage, cross-language port parity"
  homepage "https://github.com/Eagle-Logic/context"
  version "0.22.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.22.0/code-context-aarch64-apple-darwin.tar.xz"
      sha256 "314ca3183b8cf4df655cdb68f21481e178f298f4109bc204b3544c787b927d8c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.22.0/code-context-x86_64-apple-darwin.tar.xz"
      sha256 "074001d1160f5acf196272758e9451dc0cd8ba1978ead1d8b09f4670b91d91ff"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.22.0/code-context-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bc18a2ac1bd539d3086b515a509f85a280cc9d54b0618629efb7f3c3384e2232"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Eagle-Logic/context/releases/download/v0.22.0/code-context-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "63481aaa43637881563e90768dc936923cbbc8393617c3b14eba134891c4a659"
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
