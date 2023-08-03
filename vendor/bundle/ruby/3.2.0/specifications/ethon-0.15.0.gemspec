# -*- encoding: utf-8 -*-
# stub: ethon 0.15.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ethon".freeze
  s.version = "0.15.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Hans Hasselberg".freeze]
  s.date = "2021-10-12"
  s.description = "Very lightweight libcurl wrapper.".freeze
  s.email = ["me@hans.io".freeze]
  s.homepage = "https://github.com/typhoeus/ethon".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Libcurl wrapper.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<ffi>.freeze, [">= 1.15.0"])
end
