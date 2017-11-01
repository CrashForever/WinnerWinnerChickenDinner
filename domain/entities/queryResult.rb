# frozen_string_literal: false

require 'dry-struct'

module VideosPraise
  module Entity
    # Domain entity object for any git repos
    class QueryResult < Dry::Struct
      attribute :id, Types::Int.optional
      attribute :video_id, Types::Strict::String
    end
  end
end
