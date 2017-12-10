require 'roda'

module VideosPraise
  # Web API
  class Api < Roda
    plugin :halt
    plugin :all_verbs

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
              find_result = FindDatabaseRepo.call(
                query_name: query_name
              )

              http_response = HttpResponseRepresenter.new(find_result.value)
              response.status = http_response.http_code
              puts find_result.value.message
              if find_result.success?
                VideosRepresenter.new(find_result.value.message).to_json
              else
                http_response.to_json
              end
            end

            routing.post do
              service_result = LoadFromYoutube.new.call(
                   config: app.config,
                   query_name: query_name
              )
              ### store query name
              storequeryname = StoreQueryName.call(query_name: query_name)

              http_response = HttpResponseRepresenter.new(service_result.value)
              response.status = http_response.http_code
              if service_result.success?
                 response['Location'] = "/api/v0.1/videosearch/#{query_name}"
                 VideosRepresenter.new(service_result.value.message).to_json
              else
                 http_response.to_json
              end

            end

          end
          routing.on 'getAll' do
            routing.get do

              find_all_result = GetAllVideoes.call()

              http_response = HttpResponseRepresenter.new(find_all_result.value)
              response.status = http_response.http_code
              puts find_all_result.value.message
              if find_all_result.success?
                ALLVideosRepresenter.new(find_all_result.value.message).to_json
              else
                http_response.to_json
              end

            end

          end
          routing.on 'storequeryName', String do |query_name|
            routing.get do

              result = StoreQueryName.call(query_name: query_name)

              http_response = HttpResponseRepresenter.new(result.value)
              response.status = http_response.http_code
              # puts find_all_result.value.message[:query_name]
              # puts find_all_result.value.message[:number]

              if result.success?
                QueryNumberRepresenter.new(result.value.message).to_json
              else
                http_response.to_json
              end

            end
            routing.post do

              result = GetQueryNameNum.call(query_name: query_name)

              http_response = HttpResponseRepresenter.new(result.value)
              response.status = http_response.http_code
              # puts find_all_result.value.message[:query_name]
              # puts find_all_result.value.message[:number]

              if result.success?
                QueryNumberRepresenter.new(result.value.message).to_json
              else
                http_response.to_json
              end

            end
          end

          routing.on 'delete_videos' do
            routing.delete do
              %i[queryNames queryResults queryNumbers].each do |table|
                Api.DB[table].delete
              end
              http_response = HttpResponseRepresenter
                                .new(Result.new(:ok, 'deleted tables'))
              response.status = http_response.http_code
              http_response.to_json
            end
          end

          routing.on 'google_vision' do
            routing.post do
              file = routing.params['file']
              puts 'in routing.on'
              puts file
              result = ImageAnalyze.new.call(file: file)
              #
              # http_response = HttpResponseRepresenter.new(result.value)
              # response.status = http_response.http_code
              # puts find_all_result.value.message[:query_name]
              # puts find_all_result.value.message[:number]
              http_response = HttpResponseRepresenter
                                .new(Result.new(:ok, 'Analyze success'))
              response.status = http_response.http_code
              http_response.to_json              # if result.success?
              #   QueryNumberRepresenter.new(result.value.message).to_json
              # else
              #   http_response.to_json
              # end

            end
          end



        end
      end
    end
  end
end
