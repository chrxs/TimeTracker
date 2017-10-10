class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :name, null: false, default: ""
      t.string :slack_uid, null: false, default: ""
      t.string :image_24
      t.string :image_32
      t.string :image_48
      t.string :image_72
      t.string :image_192
      t.string :image_512
      t.boolean :is_admin, default: 0, null: false

      t.timestamps null: false
    end

    add_index :users, :slack_uid, unique: true
  end
end
