ENV["RAILS_ENV"]="test"
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ebisu_connection'

EbisuConnection.env = "test"
EbisuConnection.slaves_file = File.join(File.dirname(__FILE__), "slaves.yaml")
require File.join(File.dirname(__FILE__), "prepare.rb")
