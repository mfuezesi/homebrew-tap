class Rsync < Formula
  desc "Utility that provides fast incremental file transfer"
  homepage "https://rsync.samba.org/"
  url "https://download.samba.org/pub/rsync/src/rsync-3.1.0.tar.gz"
  sha256 "81ca23f77fc9b957eb9845a6024f41af0ff0c619b7f38576887c63fa38e2394e"

  bottle do
    cellar :any
    revision 1
    sha256 "164e7c934b2de1b49b1885e96903386ea808cb552a3c9dd9e585f7b98ae865cd" => :yosemite
    sha256 "96ee2027bfe92f0b5d3f5812eb8b23a46141134ad8308acda9856a591a9ca807" => :mavericks
    sha256 "3d8b560ebbb6474976804f229ac4861a18aca29ce8541bcb65807096127a3e5f" => :mountain_lion
  end

  depends_on "autoconf" => :build

  if OS.mac?
    patch do
      url "https://raw.githubusercontent.com/mfuezesi/homebrew-tap/master/rsync/v3.1.0/fileflags.diff"
      sha256 "14002d60673001219de76db7900f346344485b6ecf5c3d669fc769b8e884b96b"
    end

    patch do
      url "https://raw.githubusercontent.com/mfuezesi/homebrew-tap/master/rsync/v3.1.0/crtimes.diff"
      sha256 "89b509c58cb0bf52ff5619d426c1aa164f69945059bd7aabbc1492f8caff7706"
    end

    patch do
      url "https://raw.githubusercontent.com/mfuezesi/homebrew-tap/master/rsync/v3.1.0/hfs-compression.diff"
      sha256 "e31bc7839068137a154c21cf963bc25221bd62df72b23289067dae0d7c7d1dbc"
    end
    
    patch do
      url "https://raw.githubusercontent.com/mfuezesi/homebrew-tap/master/rsync/v3.1.0/detect-renamed.diff"
      sha256 "cc34d38f85cdc3e0a0825549715514e727f3a795c536385acddf9dd22cb34ec8"
    end
  end

  def install
    system "./prepare-source"
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--with-rsyncd-conf=#{etc}/rsyncd.conf",
                          "--enable-ipv6"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"rsync", "--version"
  end
end
