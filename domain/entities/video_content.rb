require 'dry-struct'
require_relative 'queryResult.rb'

module VideosPraise
  module Entity
    class VideoContent < Dry::Struct
      attribute :all_videos, Types::Strict::Array.member(QueryResult)
    end
  end
end
