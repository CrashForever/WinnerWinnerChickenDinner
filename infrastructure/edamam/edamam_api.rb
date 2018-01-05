require 'http'

module VideosPraise
  # Library for FacebookAPI
  module Edamam
    # Youtube Api
    class Api
      module Errors
        # Not allowed to access resource
        Unauthorized = Class.new(StandardError)
        # Requested resource not found
        NotFound = Class.new(StandardError)
      end
      # Encapsulates API response success and errors
      class Response
        HTTP_ERROR = {
          # Not allowed to access resource
          401 => Errors::Unauthorized,
          404 => Errors::NotFound
        }.freeze

        def initialize(response)
          @response = response
        end

        def successful?
          HTTP_ERROR.keys.include?(@response.code) ? false : true
        end

        def response_or_error
          successful? ? @response : raise(HTTP_ERROR[@response.code])
        end
      end

      def initialize(id, key)
        @APP_ID = id
        @API_KEY = key
      end

      def get_recipe(query_name)
        # 要對query_name做空白=%20的處理
        # query_name_esc = CGI.escape(query_name)
        edamam_request_rul = Api.get_search_path(query_name.to_s)
        call_edamam_api_url(edamam_request_rul).parse
      end

      private

      def call_edamam_api_url(url)
        response = HTTP.headers(
          'Accept' => 'application/json'
        ).get(url + "&app_id=#{@APP_ID}" + "&app_key=#{@API_KEY}")
        Response.new(response).response_or_error
      end

      def self.get_search_path(query_name)
        'https://api.edamam.com/search?from=0&to=9&q=' + query_name
      end
    end
  end
end
