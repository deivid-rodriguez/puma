#
# NOTE: Java strategy borrowed from bcrypt gem
#
if RUBY_PLATFORM == "java"
  # Don't do anything when run in JRuby; this allows gem installation to pass.
  # We need to write a dummy Makefile so that RubyGems doesn't think compilation
  # failed.
  File.open('Makefile', 'w') do |f|
    f.puts "all:"
    f.puts "\t@true"
    f.puts "install:"
    f.puts "\t@true"
  end
  exit 0
else
 require 'mkmf'

  dir_config("puma_http11")

  if %w'crypto libeay32'.find {|crypto| have_library(crypto, 'BIO_read')} and
    %w'ssl ssleay32'.find {|ssl| have_library(ssl, 'SSL_CTX_new')}

    create_makefile("puma/puma_http11")
  end
end
