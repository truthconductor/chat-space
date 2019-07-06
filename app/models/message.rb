class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  # imageを送らないときテキストは必ず入れるようにするバリデーション
  validates :body, presence: true, unless: :image?

  # アップローダーを紐付け
  mount_uploader :image, ImageUploader
end
