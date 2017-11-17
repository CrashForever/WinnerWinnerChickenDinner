# frozen_string_literal: true

module VideosPraise
  module Repository
    # Repository for Collaborators
    class QueryResults
      def self.find_id(id)
        db_record = Database::QueryResultsOrm.first(id: id)
        rebuild_entity(db_record)
      end
      def self.find_all()
        db_record = Database::QueryResultsOrm.all
        results=[]
        db_record.each do |items|
          results.push(self.rebuild_entity(items))
        end
        Entity::VideoContent.new(
          all_videos: results
        )
      end
      def self.find_video_id(video_id)
        db_record = Database::QueryResultsOrm.first(video_id: video_id)
        rebuild_entity(db_record)
      end

      def self.create(entity)
        # find_video_id(entity.videoId) || create_from(entity)
        create_from(entity)
      end

      def self.create_from(entity)
        results = []
        entity.each do |video_id|
          db_queryResults = Database::QueryResultsOrm.create(
            video_id: video_id
          )
          results.push(self.rebuild_entity(db_queryResults))
        end
        return results
        # db_queryResults = Database::QueryResultsOrm.create(
        #   video_id: entity.videoId
        # )
        #
        # self.rebuild_entity(db_queryResults)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::QueryResult.new(
          id: db_record[:id],
          video_id: db_record[:video_id]
        )
      end
    end
  end
end
