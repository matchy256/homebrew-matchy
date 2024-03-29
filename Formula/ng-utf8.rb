require 'etc'

class NgUtf8 < Formula
  desc 'Ng (Micro Nemacs). Applied UTF-8 patch. see http://hidev.blog.so-net.ne.jp/2007-03-09'
  homepage 'http://tt.sakura.ne.jp/~amura/ng/'
  url 'http://tt.sakura.ne.jp/~amura/archives/ng/ng-1.5beta1.tar.gz'
  sha256 '990b2ed34f2943da71af6771c0ac9a62c36857d6e6e6ad6e7dc8782860388d3c'
  version '1.5beta1'

  patch do
    url %Q(file://#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy256/homebrew-matchy/Resources/ng-utf8/ng-1.5beta1-utf8.patch.gz)
    sha256 '536720cdeadd0d1ba36bff8c0f97deb574f248789464dbe3f6e280179e9faf76'
  end
  patch do
    url %Q(file://#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy256/homebrew-matchy/Resources/ng-utf8/ng-1.4.3-mkstemp.patch)
    sha256 '7425ce639d812f1a6746909dd3eb3bb8817c99c33fce42cbaa96c039ffe35778'
  end
  patch do
    url %Q(file://#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy256/homebrew-matchy/Resources/ng-utf8/ng-1.4.4-glibc235.patch)
    sha256 'ef745482c7d2b568208a14c5f2fc8c9262f675fc2ce0d4a8e3d57c5cb60a8ee4'
  end
  patch do
    url %Q(file://#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy256/homebrew-matchy/Resources/ng-utf8/ng-1.5beta1-gcc421.patch)
    sha256 '35d177d629a2dc580e9be759957703b3748c8597f3cc6b70db0f6e2ca9d13ed3'
  end

  def install
    system "CFLAGS=-'Wreturn-type -Wno-implicit-function-declaration' ./configure --enable-header_stdc --prefix=#{prefix}"
    inreplace "Makefile" do |s|
      s.gsub! "-o root -g wheel", ""
    end
    system "make"
    mkdir_p "#{prefix}/bin"
    mkdir_p "#{prefix}/share"
    mkdir_p "#{prefix}/etc/skel"
    system "make install"
    homerc = %Q(#{Etc.getpwuid.dir}/.ng)
    dstrc = %Q(#{prefix}/etc/skel/dot.ng)
    tmprc  = %Q(#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy256/homebrew-matchy/Resources/ng-utf8/dot.ng)
    cp tmprc, dstrc
    unless (File.exists?(homerc)) then
      puts "You should execute \"cp #{dstrc} #{homerc}\""
    end
  end
end
