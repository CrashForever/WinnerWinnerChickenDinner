require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'


require_relative '../lib/youtube_api.rb'

CONFIG = YAML.safe_load(File.read('./config/secrets.yml'))
CORRECT = YAML.load(File.read('./spec/fixtures/results.yml'))
CASSTTE_FILE = 'ytAPI'.freeze
