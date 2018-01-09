# frozen_string_literal: true

require 'aws-sdk-sqs'
require 'econfig'

module VideosPraise
  module Messaging
    # Queue wrapper for AWS SQS
    # Requires: AWS credentials loaded in ENV or through config file
    class Queue
      GROUP_ID = 'videopraise_api'
      IDLE_TIMEOUT = 5 # seconds

      def initialize(queue_url)
        @queue_url = queue_url
        @queue = Aws::SQS::Queue.new(@queue_url)
      end

      ## Sends message to queue
      # Usage:
      #   q = Messaging::Queue.new(app.config.SCHEDULED_QUEUE_URL)
      #   q.send({data: "hello"}.to_json)
      def send(message)
        unique = message.hash.to_s + Time.now.hash.to_s

        @queue.send_message(
          message_body: message,
          message_group_id: GROUP_ID,
          message_deduplication_id: unique
        )
      end

      ## Polls queue, yielding each messge
      # Usage:
      #   q = Messaging::Queue.new(app.config.SCHEDULED_QUEUE_URL)
      #   q.poll { |msg| print msg.body.to_s }
      def poll
        poller = Aws::SQS::QueuePoller.new(@queue_url)
        poller.poll(idle_timeout: IDLE_TIMEOUT) do |msg|
          yield msg.body if block_given?
        end
      end
    end
  end
end
