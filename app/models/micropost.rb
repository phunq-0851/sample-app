class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_by -> {order created_at: :desc}
  scope :conditionId, ->(id){where user_id: id}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.onehundforty}
  validate :picture_size

  private
  def picture_size
    return unless picture.size > 5.megabytes
    errors.add(:picture, I18n.t "models.micropost.less")
  end
end
