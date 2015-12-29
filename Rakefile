require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint'

PuppetLint.configuration.send('disable_variable_scope')
task :default => [:spec, :lint]