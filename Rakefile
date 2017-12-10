require 'rake/testtask'

task :default do
  puts `rake -T`
end

# Configuration only -- not for direct calls
task :config do
  require_relative 'config/environment.rb' # load config info
  @app = VideosPraise::Api
  @config = @app.config
end

desc 'run tests'
Rake::TestTask.new(:spec) do |t|
    t.pattern = 'spec/*_spec.rb'
    t.warning = false
end

desc 'rerun tests'
task :respec do
  sh "rerun -c 'rake spec' --ignore 'coverage/*'"
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
      app.DB.drop_table :queryNumbers
      app.DB.drop_table :schema_info

  end

  desc 'Reset all database tables'
  task reset: [:drop, :migrate]
end

namespace :queue do
  require 'aws-sdk-sqs'

  desc "Create SQS queue for Shoryuken"
  task :create => :config do
    sqs = Aws::SQS::Client.new(region: @config.AWS_REGION)

    begin
      queue = sqs.create_queue(
        queue_name: @config.CLONE_QUEUE,
        attributes: {
          FifoQueue: 'true',
          ContentBasedDeduplication: 'true'
        }
      )

      q_url = sqs.get_queue_url(queue_name: @config.CLONE_QUEUE)
      puts "Queue created:"
      puts "Name: #{@config.CLONE_QUEUE}"
      puts "Region: #{@config.AWS_REGION}"
      puts "URL: #{q_url.queue_url}"
      puts "Environment: #{@app.environment}"
    rescue => e
      puts "Error creating queue: #{e}"
    end
  end

  task :purge => :config do
    sqs = Aws::SQS::Client.new(region: @config.AWS_REGION)

    begin
      queue = sqs.purge_queue(queue_url: @config.CLONE_QUEUE_URL)
      puts "Queue #{@config.CLONE_QUEUE} purged"
    rescue => e
      puts "Error purging queue: #{e}"
    end
  end
end
