class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text        :body, null: true
      t.string      :image, null: true
      t.references  :group, null: false, foreign_key: true
      t.references  :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
