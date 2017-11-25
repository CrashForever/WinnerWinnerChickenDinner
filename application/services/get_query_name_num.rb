# frozen_string_literal: true

require 'dry-monads'

module VideosPraise
  # Service to find a repo from our database
  # Usage:
  #   result = FindDatabaseRepo.call(ownername: 'soumyaray', reponame: 'YPBT-app')
  #   result.success?
  module GetQueryNameNum
    extend Dry::Monads::Either::Mixin

    def self.call(input)
      puts input[:query_name].to_s
      query_results = Repository::For[Entity::QueryNumber]
             .find_query_name_numbers(input[:query_name].to_s)
      if query_results
        Right(Result.new(:ok, query_results))
      else
        Left(Result.new(:not_found, 'Could not stored quert name to queryNumber db'))
      end
    end
  end
end
