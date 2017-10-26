require 'http'
require 'vcr'
require 'webmock'
require_relative 'video_data.rb'

module VideosPraise
  # Library for FacebookAPI
  class YoutubeAPI
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

    def initialize(config)
      @API_KEY = config['GOOGLE_API_KEY']
    end

    def get_video(query_name)
      #要對query_name做空白=%20的處理
      query_name = query_name.gsub!(' ', '%20')

      youtube_request_rul = YoutubeAPI.get_search_path(query_name.to_s)
      puts youtube_request_rul
      raw_youtube_Api_response = (call_youtube_api_url(youtube_request_rul))
      results = YoutubeAPI.process_response(raw_youtube_Api_response)

      video_id_ary = []
      results['items'].each do |item|
        video_id_ary.push(VideoData.new(item))
      end
      video_id_ary
    end

    private

    def call_youtube_api_url(url)
      HTTP.headers(
        'Accept' => "application/json"
      ).get(url + "&key=#{@API_KEY}")
    end
    def self.process_response(response)

      parsed_response = JSON.parse(response)
      youtube_response = {}
      youtube_results = {}

      youtube_response['res'] = response
      res = youtube_response['res'].parse

      youtube_results['kind'] = res['kind']
      youtube_results['etag'] = res['etag']
      youtube_results['nextPageToken'] = res['nextPageToken']
      youtube_results['regionCode'] = res['regionCode']
      youtube_results['pageInfo'] = res['pageInfo']
      youtube_results['items'] = res['items']
      youtube_results
    end
    def self.get_search_path(query_name)
      'https://www.googleapis.com/youtube/v3/search?part=id&type=video&q=' + query_name
    end
  end
end
