module VideosPraise
  # Web API
  class Api < Roda
    plugin :all_verbs

    route('recipe') do |routing|
      # #{API_ROOT}/recipe/search/:query_name
      routing.on 'search', String do |query_name|
        routing.get do
          service_result = LoadFromEdamam.call(
            config: Api.config,
            query_name: query_name
          )
          http_response = HttpResponseRepresenter.new(service_result.value)
          puts http_response
          response.status = http_response.http_code
          if service_result.success?
            response['Location'] = "/api/v0.1/recipesearch/#{query_name}"
            RecipesRepresenter.new(service_result.value.message).to_json
          else
            http_response.to_json
          end
        end
      end
    end
  end
end
