class Article
  attr_reader :id, :title, :url, :description

  def initialize(id, title, description, url)
    @id = id
    @title = title
    @url = url
    @description = description
  end

end
