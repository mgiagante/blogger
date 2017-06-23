class Article < ApplicationRecord
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings # Allows to access directly from articles to tags

  has_attached_file :image
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png']

  # An alternative would be to redefine Tag#to_s to show the tag's name.
  # That way the method below would need to only call tags.join(", ")
  def tag_list
    tags.map { |tag| tag.name }.join(", ")
  end

  def tag_list=(tag_list_string)
    tag_names = tag_list_string.split(',').map do |tag_name| 
      tag_name.strip.downcase 
    end.uniq

    new_or_found_tags = tag_names.map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end

    self.tags = new_or_found_tags
  end

end
