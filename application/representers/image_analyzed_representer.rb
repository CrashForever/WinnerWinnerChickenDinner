# frozen_string_literal: true

# Represents essential Collaborator information for API output
# USAGE:
#   collab = Repository::Collaborators.find_id(1)
#   CollaboratorRepresenter.new(collab).to_json
module VideosPraise
  class ImageAnalyzedRepresenter < Roar::Decorator
    include Roar::JSON

    property :label
    property :score
  end
end
