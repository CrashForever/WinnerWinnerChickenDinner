# frozen_string_literal: false

require 'dry-struct'

module VideosPraise
  module Entity
    class GoogleVision < Dry::Struct
      # attribute :id, Types::Int.optional
      attribute :label, Types::Strict::String
      attribute :score, Types::Strict::Float
    end
  end
end
