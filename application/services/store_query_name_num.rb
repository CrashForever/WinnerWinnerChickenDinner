# frozen_string_literal: true

require 'dry-monads'

module VideosPraise
  # Service to find a repo from our database
  # Usage:
  #   result = FindDatabaseRepo.call(ownername: 'soumyaray', reponame: 'YPBT-app')
  #   result.success?
  module StoreQueryName
    extend Dry::Monads::Either::Mixin

    def self.call(input)
      puts input
      query_results = Repository::For[Entity::QueryNumber]
             .create(input)
      if query_results
        Right(Result.new(:ok, query_results))
      else
        Left(Result.new(:not_found, 'Could not stored quert name to queryNumber db'))
      end
    end
  end
end
