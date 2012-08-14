# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mms2r"
  s.version = "3.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Mondragon"]
  s.date = "2012-07-22"
  s.description = "MMS2R is a library that decodes the parts of a MMS message to disk while stripping out advertising injected by the mobile carriers."
  s.email = ["mikemondragon@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.TMail.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.TMail.txt", "README.rdoc"]
  s.homepage = "https://github.com/monde/mms2r"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = [["lib"]]
  s.rubyforge_project = "mms2r"
  s.rubygems_version = "1.8.15"
  s.summary = "Extract user media from MMS (and not carrier cruft)"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, ["= 0.9.2.2"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_runtime_dependency(%q<mail>, [">= 2.4.0"])
      s.add_runtime_dependency(%q<exifr>, [">= 1.0.3"])
      s.add_runtime_dependency(%q<json>, [">= 1.6.0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<rake>, ["= 0.9.2.2"])
      s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_dependency(%q<mail>, [">= 2.4.0"])
      s.add_dependency(%q<exifr>, [">= 1.0.3"])
      s.add_dependency(%q<json>, [">= 1.6.0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, ["= 0.9.2.2"])
    s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
    s.add_dependency(%q<mail>, [">= 2.4.0"])
    s.add_dependency(%q<exifr>, [">= 1.0.3"])
    s.add_dependency(%q<json>, [">= 1.6.0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
