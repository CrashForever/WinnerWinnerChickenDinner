source 'https://rubygems.org'

# Networks
gem 'http'

# Web app related
gem 'econfig'
gem 'pry' # to run console in production
gem 'puma'
gem 'slim'
gem 'rake' # to run migrations in production
gem 'hirb'
gem 'sequel'
gem 'roda'

# Data gems
gem 'dry-types'
gem 'dry-struct'



# Representers
gem 'roar'
gem 'multi_json'

# Services
gem 'dry-monads'
gem 'dry-transaction'

group :test do
  gem 'minitest'
  gem 'minitest-rg'
  gem 'rack-test'
  gem 'rake'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'database_cleaner'

  gem 'rerun'
  gem 'flog'
  gem 'reek'
  gem 'rubocop'
  gem 'json'
end

group :production do
  gem 'pg'
end
