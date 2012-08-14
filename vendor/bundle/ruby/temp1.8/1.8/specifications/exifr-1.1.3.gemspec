# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "exifr"
  s.version = "1.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["R.W. van 't Veer"]
  s.date = "2012-05-31"
  s.email = "remco@remvee.net"
  s.executables = ["exifr"]
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG"]
  s.files = ["bin/exifr", "README.rdoc", "CHANGELOG"]
  s.homepage = "http://github.com/remvee/exifr/"
  s.rdoc_options = ["--title", "EXIF Reader for Ruby API Documentation", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "EXIF Reader is a module to read EXIF from JPEG images."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
