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
      # puts "666666666"
      ENV['DATABASE_URL'] = 'sqlite://' + config.db_filename
    end

    configure :production do
      # Use Heroku's DATABASE_URL environment variable
      # ENV['DATABASE_URL'] = "postgres://wgjghaymxsihxk:8783032fea57e2f3f1922c44bf23783f4d71bc1c186d49888c7d69853a7defcf@ec2-107-22-187-21.compute-1.amazonaws.com:5432/d167khd5aki3nh"
      # puts "77777777"

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
