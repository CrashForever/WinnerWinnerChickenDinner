# frozen_string_literal: true

module VideosPraise
  module Repository
    # Repository for Collaborators
    class QueryResults
      def self.find_id(id)
        db_record = Database::QueryResultsOrm.first(id: id)
        rebuild_entity(db_record)
      end

      def self.find_video_id(video_id)
        db_record = Database::QueryResultsOrm.first(video_id: video_id)
        rebuild_entity(db_record)
      end

      def self.find_or_create(entity)
        find_video_id(entity.video_id) || create_from(entity)
      end

      def self.create_from(entity)
        db_queryResults = Database::QueryResultsOrm.create(
          video_id: entity.id,
          video_id: entity.video_id,
        )

        self.rebuild_entity(db_queryResults)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record
        Entity::QueryResult.new(
          video_id: db_record.id,
          video_id: db_record.id,
        )
      end
    end
  end
end
