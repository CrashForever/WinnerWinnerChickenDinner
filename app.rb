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
            puts res.load(query_name)
            begin
              video = res.load(query_name)
              video_results = []

              video.each do |x|
                puts x.videoId
                puts '======='
                puts x.kind
                video_results << {
                  videoId: x.videoId,
                  kind: x.kind
                }
                video_results
              end
            rescue StandardError
              routing.halt(404, error: 'Video not found')
            end
            # puts config.GOOGLE_API_KEY
            # puts query_name
            # {
            #   key: key,
            #   name: query_name
            # }
          end
        end
      end
    end
  end
end
