# frozen_string_literal: true

module VideosPraise
  module Repository
    # Repository for Collaborators
    class QueryNumbers
      def self.find_id(id)
        db_record = Database::QueryNumbersOrm.first(id: id)
        rebuild_entity(db_record)
      end
      def self.find_query_name_numbers(queryName)
        db_record = Database::QueryNumbersOrm.where(query_name: queryName)
        # db_record.to_hash.each do |key,value|
        #   video_id_ary.push({'video_id': value[:video_id]})
        # end

        # new_record = Hash.new()
        # new_record[:query_name] =
        rebuild_entity_for_query(db_record.to_hash)
      end

      def self.create(entity)
        # find_video_id(entity.videoId) || create_from(entity)
        create_from(entity)
      end

      def self.create_from(entity)
        db_queryResults = Database::QueryNumbersOrm.create(
          query_name: entity[:query_name]
        )
        self.rebuild_entity(entity)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record
        Entity::QueryNumber.new(
          query_name: db_record[:query_name],
          number: db_record.count()
        )
      end

      def self.rebuild_entity_for_query(db_record)
        return nil unless db_record

        Entity::QueryNumber.new(
          query_name: db_record.first[1][:query_name],
          number: db_record.count()
        )
      end
    end
  end
end
