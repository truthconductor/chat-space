class Group < ApplicationRecord
  has_many :members
  has_many :users, through: :members

  #name属性に値が存在しない場合バリデーションエラー
  validates :name, presence: true, uniqueness: true
end
