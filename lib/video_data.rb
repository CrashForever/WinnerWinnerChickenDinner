module VideosPraise
  # Data Structure for Post
  class VideoData
    def initialize(data)
      @data = data
    end

    def videoId
      @data['id']['videoId']
    end
  end
end
