# frozen_string_literal: true

require 'dry/transaction'
require 'base64'

module VideosPraise
  # Transaction to load repo from Github and save to database
  class CameraPhotoAnalyze
    include Dry::Transaction

    step :photo_to_base64
    # step :check_if_video_already_loaded
    step :google_vision_api

    def photo_to_base64(input)
      #puts "in photo_to_base64"
      encoded_string = input[:photo].gsub('data:image/png;base64,', '')
      encoded_string = encoded_string.gsub(' ','+')
      Right(config: input[:config], base64_file_string: encoded_string)
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
      # puts 'in google_vision_api'
      results = GoogleVision::GoogleMapper.new(input[:config]).load(input[:base64_file_string])
      Right(Result.new(:ok, results))
    rescue StandardError => e
      puts e.to_s
      Left(Result.new(:internal_error, 'error when file analyzed'))
    end
  end
end
