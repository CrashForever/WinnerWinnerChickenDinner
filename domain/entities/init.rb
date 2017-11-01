require 'dry-types'

module VideosPraise
  module Entity
    module Types
      include Dry::Types.module
    end
  end
end
Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end
