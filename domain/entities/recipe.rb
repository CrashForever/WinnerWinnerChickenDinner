# frozen_string_literal: false

require 'dry-struct'

module VideosPraise
  module Entity
    class Recipe < Dry::Struct
      # attribute :id, Types::Int.optional
      attribute :query_name, Types::Strict::String
      attribute :label, Types::Strict::Array
      attribute :image, Types::Strict::Array
      attribute :url, Types::Strict::Array
    end
  end
end
