require 'http'
require 'net/http'
require 'uri'

module VideosPraise
  # Library for FacebookAPI
  module GoogleVision
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

      def initialize(key)
        @API_KEY = key
        # puts 'in google_vision_api.rb init'
        # puts @ACCESS_TOKEN
      end

      def analyze(base64_file_string)
        #要對query_name做空白=%20的處理

        api_request_rul = Api.get_search_path
        # puts api_request_rul
        # request_body =
        @request_body = {
            "requests" => [
              {
                "image" =>{
                  "content" => base64_file_string
                },
                "features" =>[
                  {
                    "type"=> "LABEL_DETECTION",
                    "maxResults"=> 1
                  }
                ]
              }
            ]
        }.to_json
        #puts @request_body
        call_google_api_url(api_request_rul).parse
      end

      private

      def call_google_api_url(url)

        # https = HTTP.new(url)
        # # https.use_ssl = true
        # req = HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
        # req['foo'] = 'bar'
        # req.body = "[ #{@toSend} ]"
        # res = https.request(req)

        # uri = URI(url)
        # http = Net::HTTP.new(url)
        # req = Net::HTTP::Post.new(url, initheader = {'Content-Type' =>'application/json','Authorization' => "Bearer #{@ACCESS_TOKEN}"})
        # req.body = @request_body
        # response = http.request(req)
        # puts "response #{res.body}"
        puts url+ "key=#{@API_KEY}"
        response = HTTP.headers(
          'Accept' => "application/json"
        ).post(url+ "key=#{@API_KEY}", :body=>@request_body)
        # puts response
        Response.new(response).response_or_error
      end

      def self.get_search_path
        #'https://www.googleapis.com/youtube/v3/search?part=id&type=video&q=' + query_name
        'https://vision.googleapis.com/v1/images:annotate?'
      end
    end
  end
end
