# frozen_string_literal: true

require 'dry/transaction'
require 'base64'

module VideosPraise
  # Transaction to load repo from Github and save to database
  class ImageAnalyze
    include Dry::Transaction

    step :img_to_base64
    # step :check_if_video_already_loaded
    step :google_vision_api

    def img_to_base64(input)

      encoded_string = Base64.encode64(input[:file][:tempfile].read)

      Right(base64_file_string: encoded_string)
    rescue StandardError
      Left(Result.new(:bad_request, 'error when file encoded '))
    end

    # def check_if_video_already_loaded(input)
    #   if Repository::For[input[:video].class].find_queryName_results(input[:video])
    #     Left(Result.new(:conflict, 'Videos already loaded'))
    #   else
    #     Right(input)
    #   end
    # end

    def google_vision_api(input)
      puts 'in google_vision_api'
      # {
      #   "requests": [
      #     {
      #       "image": {
      #         "content": ""},
      #       "features": [
      #         {
      #           "type": "LABEL_DETECTION",
      #           "maxResults": 1
      #         }
      #       ]
      #     }
      #   ]
      # }
      results = GoogleVision::GoogleMapper.new(input[:config]).load(input[:query_name])

      Right(Result.new(:ok, 'nice'))
    rescue StandardError => e
      puts e.to_s
      Left(Result.new(:internal_error, 'error when file analyzed'))
    end
  end
end
