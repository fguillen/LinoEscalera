class Page < ActiveRecord::Base
  attr_accessible :text, :text_es, :title

  validates :title, :presence => true, :uniqueness => true
  validates :text, :presence => true
end
