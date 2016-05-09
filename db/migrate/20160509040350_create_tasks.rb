class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true
      t.references :list, index: true
      t.string :title, default: ""
      t.text :description, default: ""
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
