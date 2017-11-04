require 'rake/testtask'

desc 'run tests'
Rake::TestTask.new(:spec) do |t|
    t.pattern = 'spec/*_spec.rb'
    t.warning = false
end

task :console do
  sh 'pry -r ./spec/test_load_all'
end

namespace :quality do

  desc 'run flog'
  task :flog do
    sh 'flog lib/'
  end

  desc 'run reek'
  task :reek do
    sh 'reek lib/'
  end

  desc 'run rubocop'
  task :rubocop do
    sh 'rubocop'
  end
end

namespace :db do
  require_relative 'config/environment.rb'
  require 'sequel'

  Sequel.extension :migration
  app = VideosPraise::Api

  desc 'Run migrations'
  task :migrate do
    puts "Migrating #{app.environment} database to latest"
    Sequel::Migrator.run(app.DB, 'infrastructure/database/migrations')
  end

  desc 'Drop all tables'
  task :drop do
      require_relative 'config/environment.rb'

      app.DB.drop_table :queryNames
      app.DB.drop_table :queryResults

  end

  desc 'Reset all database tables'
  task reset: [:drop, :migrate]
end
