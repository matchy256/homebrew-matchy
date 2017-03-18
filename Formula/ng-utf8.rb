require 'formula'
require 'fileutils'
require 'etc'

class NgUtf8 < Formula
  url 'http://tt.sakura.ne.jp/~amura/archives/ng/ng-1.5beta1.tar.gz'
  homepage 'http://tt.sakura.ne.jp/~amura/ng/'
  sha256 '990b2ed34f2943da71af6771c0ac9a62c36857d6e6e6ad6e7dc8782860388d3c'
  version '1.5beta1'

  patch do
    url 'http://www002.upp.so-net.ne.jp/hidev/ng-1.5beta1-utf8.patch.gz'
    sha256 '2d2f8a65ba83e090af52879d757b491ff5701ffcac4a003707b11e0a2dd05c82'
  end
  patch do
    url %Q(file://#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy2/homebrew-matchy/Resources/ng-utf8/ng-1.4.3-mkstemp.patch)
    sha256 '7425ce639d812f1a6746909dd3eb3bb8817c99c33fce42cbaa96c039ffe35778'
  end
  patch do
    url %Q(file://#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy2/homebrew-matchy/Resources/ng-utf8/ng-1.4.4-glibc235.patch)
    sha256 'ef745482c7d2b568208a14c5f2fc8c9262f675fc2ce0d4a8e3d57c5cb60a8ee4'
  end
  patch do
    url %Q(file://#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy2/homebrew-matchy/Resources/ng-utf8/ng-1.5beta1-gcc421.patch)
    sha256 '35d177d629a2dc580e9be759957703b3748c8597f3cc6b70db0f6e2ca9d13ed3'
  end

  def install
    system "CC='gcc -Wreturn-type' ./configure --prefix=#{prefix}"
    inreplace "Makefile" do |s|
      s.gsub! "-o root -g wheel", ""
    end
    system "make"
    mkdir_p "#{prefix}/bin"
    mkdir_p "#{prefix}/share"
    system "make install"
    homerc = %Q(#{Etc.getpwuid.dir}/.ng)
    tmprc  = %Q(#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy2/homebrew-matchy/Resources/ng-utf8/dot.ng)
    unless (File.exists?(homerc)) then
      FileUtils.cp(tmprc, homerc)
      puts "copy #{tmprc} to #{homerc}"
    end
  end
end
