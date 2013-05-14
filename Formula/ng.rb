require 'formula'

class Ng < Formula
  url 'http://tt.sakura.ne.jp/~amura/archives/ng/ng-1.5beta1.tar.gz'
  homepage 'http://tt.sakura.ne.jp/~amura/ng/'
  md5 '70aa4906154e7884fb1305e90bdac887'
  version '1.5beta1'

  def patches
    [ 'file:///usr/local/Library/Taps/matchy2-matchy/Resources/ng/ng-1.5beta1-utf8.patch.gz',
      'file:///usr/local/Library/Taps/matchy2-matchy/Resources/ng/ng-1.4.3-mkstemp.patch',
      'file:///usr/local/Library/Taps/matchy2-matchy/Resources/ng/ng-1.4.4-glibc235.patch' ]
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
  end
end
