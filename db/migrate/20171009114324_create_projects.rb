class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.belongs_to :client
      t.string :name, null: false, default: ""

      t.timestamps
    end
  end
end
