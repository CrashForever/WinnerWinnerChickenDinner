require 'roda'

module VideosPraise
  # Web API
  class Api < Roda
    plugin :json
    plugin :halt

    route do |routing|
      app = Api

      # GET / request
      routing.root do
        { 'message' => "CodePraise API v0.1 up in #{app.environment} mode" }
      end

      routing.on 'api' do
        # /api/v0.1 branch
        routing.on 'v0.1' do
          # /api/v0.1/:ownername/:repo_name branch
          routing.on 'videosearch', String do |query_name|
            routing.get do
              # video = res.load(query_name)
              query_results = Repository::QueryNames.find_queryName_results(query_name)
              # rescue StandardError
              if query_name == 'wrong'
                routing.halt(404, error: 'Video not found')
              end
              query_results.to_h

              { video_list: query_results.to_h }
            end

            routing.post do
              begin
              video = Youtube::VideoMapper.new(app.config).load(query_name)

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
