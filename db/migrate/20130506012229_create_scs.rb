class CreateScs < ActiveRecord::Migration
  def up
    create_table :socialcards do |t|

      t.integer     :user_id
      t.string      :usecase
      t.string      :username
      t.string      :country
      t.string      :state
      t.string      :city
      t.string      :zip_code
      t.string      :name
      t.string      :title
      t.string      :description
      t.string      :main_website
      t.string      :email
      t.string      :blog
      t.attachment  :avatar

      t.timestamps
    end

    create_table :providers do |t|

      t.integer     :socialcard_id
      t.string      :provider
      t.string      :url

      t.timestamps
    end
  end

  def down
    drop_table :socialcards
    drop_table :providers
  end
end
