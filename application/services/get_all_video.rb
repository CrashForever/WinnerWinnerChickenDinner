# frozen_string_literal: true

require 'dry-monads'

module VideosPraise
  # Service to find a repo from our database
  # Usage:
  #   result = FindDatabaseRepo.call(ownername: 'soumyaray', reponame: 'YPBT-app')
  #   result.success?
  module GetAllVideoes
    extend Dry::Monads::Either::Mixin

    def self.call()
      query_results = Repository::For[Entity::QueryResult]
             .find_all()
      if query_results
        Right(Result.new(:ok, query_results))
      else
        Left(Result.new(:not_found, 'Could not find stored video information'))
      end
    end
  end
end
