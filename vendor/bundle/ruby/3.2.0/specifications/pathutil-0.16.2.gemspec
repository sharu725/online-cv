# -*- encoding: utf-8 -*-
# stub: pathutil 0.16.2 ruby lib

Gem::Specification.new do |s|
  s.name = "pathutil".freeze
  s.version = "0.16.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jordon Bedwell".freeze]
  s.date = "2018-10-30"
  s.description = "Like Pathname but a little less insane.".freeze
  s.email = ["jordon@envygeeks.io".freeze]
  s.homepage = "http://github.com/envygeeks/pathutil".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Almost like Pathname but just a little less insane.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<forwardable-extended>.freeze, ["~> 2.6"])
end
