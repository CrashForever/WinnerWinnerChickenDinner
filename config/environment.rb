require 'roda'
require 'econfig'

module VideosPraise
  # Configuration for the API
  class Api < Roda
    plugin :environments

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'

    configure :development do
      # Allows running reload! in pry to restart entire app
      def self.reload!
        exec 'pry -r ./spec/test_load_all'
      end
    end

    configure :development, :test do
      ENV['DATABASE_URL'] = 'sqlite://' + config.db_filename
    end

    configure :production do
      # Use Heroku's DATABASE_URL environment variable
      ENV['DATABASE_URL'] = 'postgres://fjvsaibjpnjcew:05d74c0e19f8d31a86b89d5b58603567e4e8fd0d631e60cd652d7bd2dfe793f4@ec2-54-163-229-169.compute-1.amazonaws.com:5432/d8okctu8d697i0'
    end

    configure do
      require 'sequel'
      DB = Sequel.connect(ENV['DATABASE_URL'])

      def self.DB
        DB
      end
    end
  end
end
