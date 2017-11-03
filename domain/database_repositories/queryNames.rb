# frozen_string_literal: true

module VideosPraise
  module Repository
    # Repository for Repo Entities
    class QueryNames
      def self.find_queryName_results(queryName)
        # SELECT * FROM `repos` LEFT JOIN `collaborators`
        # ON (`collaborators`.`id` = `repos`.`owner_id`)
        # WHERE ((`username` = 'owername') AND (`name` = 'reponame'))
        db_queryNames = Database::QueryNamesOrm.left_join(:queryResults, id: :queryResults_id)
                                   .where(query_name: queryName)
        rebuild_entity(db_queryNames)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record
        results = db_record.map do |item|
          puts item[:video_id]
          Entity::QueryName.new(
            query_name: item[:query_name],
            video_id: item[:video_id]
          )
        end
      end
    end
  end
end
