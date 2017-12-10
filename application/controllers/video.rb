module VideosPraise
  # Web API
  class Api < Roda
    plugin :all_verbs

    route('video') do |routing|
      # #{API_ROOT}/video/search/:query_name
      routing.on 'search', String do |query_name|
        routing.get do
          # video = res.load(query_name)
          find_result = FindDatabaseRepo.call(
            query_name: query_name
          )
          represent_response(find_result, VideosRepresenter)
        end

        routing.post do
          service_result = LoadFromYoutube.new.call(
            config: Api.config,
            query_name: query_name
          )
          ### store query name
          StoreQueryName.call(query_name: query_name)

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

      # #{API_ROOT}/video/getAll
      routing.on 'getAll' do
        routing.get do
          find_all_result = GetAllVideoes.call
          represent_response(find_all_result, ALLVideosRepresenter)
        end
      end

      # #{API_ROOT}/video/deleteAll
      routing.on 'deleteAll' do
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

      # #{API_ROOT}/video/storequeryName/:query_name
      routing.on 'storequeryName', String do |query_name|
        routing.get do
          result = StoreQueryName.call(query_name: query_name)
          represent_response(result, QueryNumberRepresenter)

        end
        routing.post do
          result = GetQueryNameNum.call(query_name: query_name)
          represent_response(result, QueryNumberRepresenter)

        end
      end
    end
  end
end
