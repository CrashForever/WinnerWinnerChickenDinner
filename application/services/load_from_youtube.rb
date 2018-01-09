# frozen_string_literal: true

require 'dry/transaction'

module VideosPraise
  # Transaction to load repo from Github and save to database
  class LoadFromYoutube
    include Dry::Transaction

    step :get_video_from_youtube
    # step :check_if_video_already_loaded
    step :store_video_in_repository

    def get_video_from_youtube(input)
      video = Youtube::VideoMapper.new(input[:config]).load(input[:query_name])
      Right(video: video)
    rescue StandardError
      Left(Result.new(:bad_request, 'Videos not found'))
    end

    # def check_if_video_already_loaded(input)
    #   if Repository::For[input[:video].class].find_queryName_results(input[:video])
    #     Left(Result.new(:conflict, 'Videos already loaded'))
    #   else
    #     Right(input)
    #   end
    # end

    def store_video_in_repository(input)
      stored_video = Repository::For[input[:video].class].create(input[:video])
      video_json = VideosRepresenter.new(stored_video).to_json
      notify_listeners(video_json, input[:config])
      Right(Result.new(:created, stored_video))
    rescue StandardError => e
      puts e.to_s
      Left(Result.new(:internal_error, 'Could not store videos'))
    end

    private

    def notify_listeners(message, config)
      scheduled_queue = Messaging::Queue.new(config.SCHEDULED_QUEUE_URL)
      scheduled_queue.send(message)
    end
  end
end
