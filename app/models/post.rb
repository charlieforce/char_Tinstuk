class Post < ApplicationRecord
  attr_accessor :attachment_file_name
  belongs_to :interest
  belongs_to :user
  has_many :comments

  validates :text, presence: true

  has_attached_file :attachment,
                    storage: :s3,
                    s3_host_name: ENV['S3_HOST_NAME'],
                    style: { medium: '370x370', thumb: '100x100' }

    validates_attachment_content_type :attachment,
    :content_type => ['video/mp4'],
    :if => :is_type_of_video?
  validates_attachment_content_type :attachment,
     :content_type => ['image/png', 'image/jpeg', 'image/jpg', 'image/gif'],
     :if => :is_type_of_image?
  has_attached_file :attachment

  protected
  def is_type_of_video?
    attachment.content_type =~ %r(video)
  end

  def is_type_of_image?
    attachment.content_type =~ %r(image)
  end
end
