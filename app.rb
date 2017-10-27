require 'roda'
require 'econfig'
# require_relative 'lib/init.rb'

module VideosPraise
  # Web API
  class Api < Roda
    plugin :environments
    plugin :json
    plugin :halt

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'
    puts Econfig.env
    route do |routing|
      app = Api
      config = Api.config
      # puts '---------'
      # puts config
      # puts '---------'

      # GET / request
      routing.root do
        { 'message' => "CodePraise API v0.1 up in #{app.environment}" }
      end

      routing.on 'api' do
        # /api/v0.1 branch
        routing.on 'v0.1' do
          # /api/v0.1/:ownername/:repo_name branch
          routing.on 'videosearch', String do |query_name|
            YouTubeAPI = Youtube::API.new(config.GOOGLE_API_KEY)
            Video_mapper = Youtube::VideoMapper.new(YouTubeAPI)
            begin
              video = Video_mapper.load(query_name)
            rescue StandardError
              routing.halt(404, error: 'Video not found')
            end

            # GET /api/v0.1/:ownername/:repo_name request
            routing.is do
              { repo: { owner: repo.owner.to_h, size: repo.size } }
            end

            # GET /api/v0.1/:ownername/:repo_name/contributors request
            routing.get 'contributors' do
              { contributors: repo.contributors.map(&:to_h) }
            end
          end
        end
      end
    end
  end
end
