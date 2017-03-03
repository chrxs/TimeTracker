class CreateUserOmniauthsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :user_omniauths do |t|
      t.references :user, foreign_key: true
      t.string :uid
      t.string :provider
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
