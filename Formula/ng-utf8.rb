require 'formula'
require 'fileutils'
require 'etc'

class NgUtf8 < Formula
  url 'http://tt.sakura.ne.jp/~amura/archives/ng/ng-1.5beta1.tar.gz'
  homepage 'http://tt.sakura.ne.jp/~amura/ng/'
  sha256 '990b2ed34f2943da71af6771c0ac9a62c36857d6e6e6ad6e7dc8782860388d3c'
  version '1.5beta1'

  def patches
    [ %Q(http://www002.upp.so-net.ne.jp/hidev/ng-1.5beta1-utf8.patch.gz),
      %Q(file://#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy2/homebrew-matchy/Resources/ng-utf8/ng-1.4.3-mkstemp.patch),
      %Q(file://#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy2/homebrew-matchy/Resources/ng-utf8/ng-1.4.4-glibc235.patch),
      %Q(file://#{ENV['HOMEBREW_LIBRARY']}/Taps/matchy2/homebrew-matchy/Resources/ng-utf8/ng-1.5beta1-gcc421.patch) ]
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
