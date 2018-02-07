class Article

  attr_accessor :article_title, :url, :description

  def initialize(article_title, url, description)
    @article_title = article_title
    @url = url
    @description = description
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def self.count
    all.count
  end

end
