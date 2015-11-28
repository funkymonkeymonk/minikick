Gem::Specification.new do |spec|
  spec.name          = "minikick"
  spec.version       = '0.0.1'
  spec.authors       = ["Will Weaver"]
  spec.email         = ["monkey@buildingbananas.com"]
  spec.summary       = %q{A simplified cli version of Kickstarter}
  spec.description   = %q{This project is to create a CLI-driven application that is emulates the most
  basic functions of Kickstarter as per the Kickstarter code test found at
  https://gist.github.com/ktheory/3c28ba04f4064fd9734f.}
  spec.homepage      = "http://github.com/funkymonkeymonk/minikick"
  spec.license       = "MIT"

  spec.files         = ['lib/minikick.rb']
  spec.executables   = ['bin/minikick']
  spec.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
