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
  after_update :remove_video_on_demand, :if => :remove_video?

  validates :title, :presence => true, :uniqueness => true
  validates :text, :presence => true
  validates :position, :presence => true

  scope :by_position, order("position asc")


  attr_accessor :remove_video

  # TODO: ugly! the point is that in test we don't use S3 so it needs another config
  if APP_CONFIG[:s3_credentials]
    has_attached_file(
      :video,
      :storage => :s3,
      :s3_credentials => APP_CONFIG[:s3_credentials],
      :path => "/:rails_env/:id/video.:extension",
    )
  else
    has_attached_file(
      :video,
      :url => "/assets/uploads/:rails_env/:id/video.:extension",
      :path => ":rails_root/public:url"
    )
  end

  def initialize_position
    self.position ||= Item.maximum(:position).to_i + 1
  end

  def to_param
    return id if title.blank?
    "#{id}-#{title.to_url}"
  end

  def thumb
    return nil if pics.empty?
    pics.by_position.first.attach(:front)
  end

  def thumb_main
    return nil if pics.empty?
    pics.by_position.first.attach(:front_main)
  end

  def pics_show
    pics.by_position[1..-1] || []
  end

  def first_in_collection?
    collection_list.each do |collection|
      return true if Item.tagged_with(collection).minimum(:position) == position
    end

    return false
  end

  def remove_video?
    remove_video == "1"
  end

  def remove_video_on_demand
    video.destroy
  end
end
