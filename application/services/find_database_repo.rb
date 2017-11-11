# frozen_string_literal: true

require 'dry-monads'

module VideosPraise
  # Service to find a repo from our database
  # Usage:
  #   result = FindDatabaseRepo.call(ownername: 'soumyaray', reponame: 'YPBT-app')
  #   result.success?
  module FindDatabaseRepo
    extend Dry::Monads::Either::Mixin

    def self.call(input)
      query_results = Repository::For[Entity::QueryName]
             .find_queryName_results(input[:query_name])
      if query_results
        Right(Result.new(:ok, query_results))
      else
        Left(Result.new(:not_found, 'Could not find stored video information'))
      end
    end
  end
end
