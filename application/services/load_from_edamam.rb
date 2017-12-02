# frozen_string_literal: true

require 'dry-monads'

module VideosPraise
  # Service to find a repo from our database
  # Usage:
  #   result = FindDatabaseRepo.call(ownername: 'soumyaray', reponame: 'YPBT-app')
  #   result.success?
  module LoadFromEdamam
    extend Dry::Monads::Either::Mixin

    def self.call(input)
      recipe = Edamam::RecipeMapper.new(input[:config]).load(input[:query_name])
      if recipe
        Right(Result.new(:ok, recipe))
      else
        Left(Result.new(:not_found, 'Recipes not found'))
      end
    end
  end
end
