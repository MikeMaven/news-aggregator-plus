class Article
  attr_reader :id, :title, :url, :description

  def initialize(title, url, description, id = nil)
    @title = title
    @url = url
    @description = description
    @id = id
  end

end
