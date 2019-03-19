class Article
  attr_reader :id, :title, :url, :description

  def initialize(title, url, description)
    @title = title
    @url = url
    @description = description
    @id = nil
  end

end
