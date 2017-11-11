# frozen_string_literal: true

# Represents essential Collaborator information for API output
# USAGE:
#   collab = Repository::Collaborators.find_id(1)
#   CollaboratorRepresenter.new(collab).to_json
module VideosPraise
  class VideosRepresenter < Roar::Decorator
    include Roar::JSON

    property :query_name
    property :video_id
  end
end
