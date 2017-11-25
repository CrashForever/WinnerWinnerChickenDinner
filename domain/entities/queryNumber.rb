# frozen_string_literal: false

require 'dry-struct'

module VideosPraise
  module Entity
    class QueryNumber < Dry::Struct
      # attribute :id, Types::Int.optional
      attribute :query_name, Types::Strict::String
      attribute :number, Types::Strict::Int
    end
  end
end
