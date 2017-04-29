class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false, default: ""
      t.string :slack_uid
      t.string :domain
      t.string :image_34
      t.string :image_44
      t.string :image_68
      t.string :image_88
      t.string :image_102
      t.string :image_132
      t.string :image_230

      t.timestamps null: false
    end

    add_index :teams, :name, unique: true
  end
end
