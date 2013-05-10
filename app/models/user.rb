class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   #acts_as_follower
  acts_as_followable
  acts_as_follower

   #paperclip
  has_attached_file :photo,
       :styles => {
       :thumb=> "75x75#",
       :small  => "400x400>" },
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:style/:id/:filename"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  validates :name, :presence => true
  validates :email, :presence => true
  validates :email, :uniqueness => true, :on => :create
  validates :email, :uniqueness => true, :on => :update 
  validates :password, :length => { :minimum => 6 }
  validates :password, :confirmation => true
  validates :password_confirmation, :presence => true
  validates :gender, :presence => true

  has_many :pledges
  attr_accessible :email, :gender, :name, :password, :password_confirmation, :photo

  def self.search(search)
    if search
      return where 'name LIKE ?', "%#{search}%"
    end
  end 
end
