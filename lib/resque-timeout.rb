require 'rubygems'
gem 'resque', :version => '~> 1.0'
require 'resque'

require File.expand_path('resque/plugins/timeout', File.dirname(__FILE__))


