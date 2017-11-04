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

      def self.create(entity)
        create_from(entity)
      end

      def self.create_from(entity)

        video_id_ary = []
        entity.video_id.each do |id|
          video_id_ary.push(id)
        end
        db_queryresultResults = QueryResults.create(video_id_ary)


        return_entity = []
        db_queryresultResults.each do |items|
          db_querynameResults = Database::QueryNamesOrm.create(
            query_name: entity.query_name,
            queryResults_id: items.id
          )
        end
        self.rebuild_entity(db_queryresultResults, entity.query_name)
        # entity.video_id.each do |id|
        #   db_queryResults = Database::QueryNamesOrm.create(
        #     query_name: entity.query_name,
        #   )
        #   self.rebuild_entity(db_queryResults)
        # end
      end

      def self.rebuild_entity(db_record,query_name)
        return nil unless db_record
        video_id_ary = []
        db_record.each do |item|
          video_id_ary.push(item.video_id)
        end

        Entity::QueryName.new(
          # id: nil,
          query_name: query_name,
          video_id: video_id_ary
        )

      end
    end
  end
end
