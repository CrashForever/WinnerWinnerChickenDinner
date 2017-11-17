# frozen_string_literal: true

# Represents essential Collaborator information for API output
# USAGE:
#   collab = Repository::Collaborators.find_id(1)
#   CollaboratorRepresenter.new(collab).to_json
require_relative 'query_results_representer.rb'
module VideosPraise
  class ALLVideosRepresenter < Roar::Decorator
    include Roar::JSON

    collection :all_videos, extend: QueryResultsRepresenter
  end
end
