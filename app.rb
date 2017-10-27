require 'roda'
require 'econfig'
#require_relative 'lib/init.rb'
require_relative './lib/youtube_api.rb'
require_relative './lib/video_mapper.rb'
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

      # GET / request
      routing.root do
        { 'message' => "CodePraise API v0.1 up in #{app.environment}" }
      end

      routing.on 'api' do
        # /api/v0.1 branch
        routing.on 'v0.1' do
          # /api/v0.1/:ownername/:repo_name branch
          routing.on 'videosearch', String do |query_name|
            key = config.GOOGLE_API_KEY
            youtubeGateway = Youtube::Api.new(key)
            res = Youtube::VideoMapper.new(youtubeGateway)
            begin
              video = res.load(query_name)
            rescue StandardError
              routing.halt(404, error: 'Video not found')
            end

            routing.is do
                {query:query_name, totalResults: video.videoId.size, videos: video.videoId}
            end
          end
        end
      end
    end
  end
end
