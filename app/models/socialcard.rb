class Socialcard < ActiveRecord::Base

  belongs_to :user
  has_many :providers

  validates_presence_of :usecase, :username, :name, :description, :email

  attr_accessible :usecase, :username, :country, :state, :city, :name, :title, :description, :email, :main_website, :blog

  validates :description, :length => { :maximum => 140 }
  validate :unique_username
  before_save :downcase_username

  has_attached_file 	:avatar,
                      :storage => :s3,
                      :default_url => ActionController::Base.helpers.asset_path("default-avatar.jpg"),
                      :bucket => 'cahoots',
                      :s3_credentials => {
                        :access_key_id => 'AKIAI576XAU7SH57QZFA',
                        :secret_access_key => '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'
                      },
                      :path => "/:attachment/:style/:id.:extension",
                      :styles => {
                        :thumb => ["400x400"]
                      }

  def unique_username
    s = Socialcard.where(:username => username.downcase).first
    if s.id != self.id
      errors.add(:username, " already exists")
    end
  end

  def downcase_username
    self.username.downcase! if self.username
  end

  def self.get_all
    Socialcard.order("created_at").all
  end

  def to_json
    sc = {
      :id => id,
      :username => username,
      :country => country,
      :state => state,
      :city => city,
      :name => name,
      :title => title,
      :description => description,
      :main_website => main_website,
      :email => email,
      :blog => blog,
      :avatar_url => avatar.url(:thumb),
      :providers => {}
    }

    providers.each do |p|
      sc[:providers][p.provider] = p.url
    end

    sc
  end

  def create_providers(providers)
    providers.each do |key, value|
      if Socialcard.valid_provider(key)
        create_provider(key, value)
      end
    end
  end

  def create_provider(provider, url)
    p = Provider.where(:socialcard_id => self.id, :provider => provider).first

    if p
      p.update_attribute(:url, url)
    else
      p = Provider.new
      p.socialcard = self
      p.provider = provider
      p.url = url
      p.save!
    end
  end

  def self.valid_provider(provider)
    providers = ['facebook', 'linkedin', 'googlePlus', 'pinterest', 'instagram', 'twitter']
    providers.include?(provider)
  end

  def display_name
    name || "My Social Card"
  end
end