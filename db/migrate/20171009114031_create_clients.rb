class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.belongs_to :team
      t.string :name, null: false, default: ""

      t.timestamps null: false
    end
  end
end
