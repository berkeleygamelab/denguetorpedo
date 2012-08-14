# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mime"
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Clint Pachl"]
  s.date = "2008-11-04"
  s.email = "pachl@ecentryx.com"
  s.homepage = "mime.rubyforge.org"
  s.require_paths = ["lib"]
  s.rubyforge_project = "mime"
  s.rubygems_version = "1.8.24"
  s.summary = "Multipurpose Internet Mail Extensions (MIME) Library"

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
