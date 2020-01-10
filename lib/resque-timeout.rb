require 'rubygems'
gem 'resque', :version => '~> 2.0'
require 'resque'

require File.expand_path('resque/plugins/timeout', File.dirname(__FILE__))
