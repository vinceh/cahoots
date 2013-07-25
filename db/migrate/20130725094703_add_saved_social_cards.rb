class AddSavedSocialCards < ActiveRecord::Migration
  def up
    create_table(:savedcards) do |t|
      t.integer  :user_id
      t.integer  :socialcard_id
      t.timestamps
    end
  end

  def down
    drop_table(:savedcards)
  end
end
