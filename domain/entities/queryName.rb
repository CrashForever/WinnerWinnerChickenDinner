# frozen_string_literal: false

require 'dry-struct'
require_relative 'queryResult.rb'

module VideosPraise
  module Entity
    # Domain entity object for any git repos
    class QueryName < Dry::Struct
      attribute :query_name, Types::Strict::String
      attribute :video_id, Types::Strict::String
    end
  end
end
