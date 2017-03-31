class CreateUserOmniauthsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :user_omniauths do |t|
      t.integer :user_id
      t.string :uid
      t.string :provider
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
