require 'roda'
require 'econfig'

module VideosPraise
  # Web API
  class Api < Roda
    plugin :environments
    plugin :json
    plugin :halt

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'

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
            # key = config.GOOGLE_API_KEY
            # youtubeGateway = Youtube::Api.new(key)
            # res = Youtube::VideoMapper.new(youtubeGateway)
            routing.get do
              # video = res.load(query_name)
              query_results = Repository::QueryNames.find_queryName_results(query_name)
              # rescue StandardError
              if query_name == 'wrong'
                routing.halt(404, error: 'Video not found')
              end
              res_result = []
              query_results.each { |x| res_result << x[:video_id] }
              { video_list: res_result }
            end
            routing.post do
              key = config.GOOGLE_API_KEY
              youtube_gateway = Youtube::Api.new(key)
              begin
              video = Youtube::VideoMapper.new(youtube_gateway).load(query_name)

              rescue StandardError
                routing.halt(404, error: "Video not found")
              end
              stored_video = Repository::For[video.class].create(video)
              response.status = 201
              response['Location'] = "/api/v0.1/videosearch/#{query_name}"
              stored_video.to_h
            end
          end
        end
      end
    end
  end
end
