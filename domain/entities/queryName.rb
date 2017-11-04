# frozen_string_literal: false

require 'dry-struct'

module VideosPraise
  module Entity
    class QueryName < Dry::Struct
      # attribute :id, Types::Int.optional
      attribute :query_name, Types::Strict::String
      attribute :video_id, Types::Strict::Array
    end
  end
end
