require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'


require_relative '../lib/youtube_api.rb'

QUERY_NAME = 'tomato recipe'.freeze
CONFIG = YAML.safe_load(File.read('./config/secrets.yml'))
TOKEN = CONFIG['GOOGLE_API_KEY']
CORRECT = YAML.load(File.read('./spec/fixtures/results.yml'))

CASSTTE_FILE = 'youtube_api'.freeze
CASSETTES_FOLDER = 'spec/fixtures/cassettes'.freeze

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock
  c.filter_sensitive_data('<API_KEY>') { TOKEN }
  c.filter_sensitive_data('<API_KEY_ESC>') { CGI.escape(TOKEN) }
end
