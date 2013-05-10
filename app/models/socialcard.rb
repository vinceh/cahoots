class Socialcard < ActiveRecord::Base

  belongs_to :user
  has_many :socialcards

  has_attached_file 	:image,
                      :storage => :s3,
                      :default_url => ActionController::Base.helpers.asset_path("rails.png"),
                      :bucket => 'cahoots',
                      :s3_credentials => {
                        :access_key_id => 'AKIAI576XAU7SH57QZFA',
                        :secret_access_key => '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'
                      },
                      :path => "/:attachment/:style/:id.:extension",
                      :styles => {
                        :thumb => ["300x300"]
                      }
end