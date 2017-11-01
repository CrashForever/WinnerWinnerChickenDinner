require 'dry-struct'

module VideosPraise
  module Entity
    class VideoContent < Dry::Struct
      attribute :videoId, Types::Strict::Array
      attribute :kind, Types::Strict::Array
    end
  end
end
