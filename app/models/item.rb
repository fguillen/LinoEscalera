class Item < ActiveRecord::Base
  COLLECTIONS = {
    :home => "home",
    :film => "film",
    :commercial => "commercial",
    :brand => "brand"
  }

  strip_attributes
  acts_as_taggable_on :collections

  has_many :pics

  attr_protected nil

  before_validation :initialize_position

  validates :title, :presence => true, :uniqueness => true
  validates :text, :presence => true
  validates :position, :presence => true

  scope :by_position, order("position asc")

  def initialize_position
    self.position ||= Item.minimum(:position).to_i - 1
  end

  def to_param
    return id if title.blank?
    "#{id}-#{title.to_url}"
  end

  def pic
    return nil if pics.empty?
    pics.first.attach(:front)
  end

  def pic_main
    return nil if pics.empty?
    pics.first.attach(:front_main)
  end
end
