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
          represent_response(service_result, RecipesRepresenter) do
              response['Location'] = "/api/v0.1/recipesearch/#{query_name}"
          end
        end
      end
    end
  end
end
