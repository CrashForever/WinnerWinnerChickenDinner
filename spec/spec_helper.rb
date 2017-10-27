ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'rack/test'
require 'vcr'
require 'webmock'

require_relative 'test_load_all'

QUERY_NAME = CGI.escape('tomato recipe').freeze
CORRECT = YAML.load(File.read('./spec/fixtures/results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'.freeze

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock

  youtube_key = app.config.GOOGLE_API_KEY
  c.filter_sensitive_data('<API_KEY>') { youtube_key }
  c.filter_sensitive_data('<API_KEY_ESC>') { CGI.escape(youtube_key) }
end
