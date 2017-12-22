class CreateLastRunTable < ActiveRecord::Migration[5.1]
  def change
    create_table :last_runs do |t|
      t.string :routine_name
      t.timestamps
    end
  end
end
