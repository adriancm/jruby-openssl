#-*- mode: ruby -*-

Gem::Specification.new do |s|
  s.name = 'jruby-openssl'

  version_rb = File.expand_path('lib/jopenssl/version.rb', File.dirname(__FILE__))
  version_rb = File.read(version_rb)
  s.version = version_rb.match( /.*\sVERSION\s*=\s*['"](.*)['"]/ )[1]

  s.platform = 'java'
  s.authors = ['Ola Bini', 'JRuby contributors']
  s.email = "ola.bini@gmail.com"
  s.summary = "JRuby OpenSSL"
  s.homepage = 'https://github.com/jruby/jruby-openssl'
  s.description = 'JRuby-OpenSSL is an add-on gem for JRuby that emulates the' <<
                  ' Ruby OpenSSL native library.'
  s.licenses = [ 'EPL-1.0', 'GPL-2.0', 'LGPL-2.1' ]

  s.require_paths = ['lib']

  s.files = `git ls-files`.split("\n").
    select { |f| f =~ /^(lib)/ ||
                 f =~ /^History|LICENSE|README|Rakefile|Mavenfile|pom.xml/i } +
    Dir.glob('lib/**/*.jar') # 'lib/jopenssl.jar' and potentially BC jars

  bc_version = version_rb.match( /.*\sBOUNCY_CASTLE_VERSION\s*=\s*['"](.*)['"]/ )[1]
  raise 'BOUNCY_CASTLE_VERSION not matched' if (bc_version || '').empty?

  s.requirements << "jar org.bouncycastle:bcpkix-jdk15on, #{bc_version}"
  s.requirements << "jar org.bouncycastle:bcprov-jdk15on, #{bc_version}"

  s.add_development_dependency 'jar-dependencies', '~> 0.1'

  s.add_development_dependency 'mocha', '~> 1.1.0'
  s.add_development_dependency 'ruby-maven', '~> 3.0'
  # NOTE: runit-maven-plugin will use it's own :
  #s.add_development_dependency 'test-unit', '2.5.5'
end

# vim: syntax=Ruby