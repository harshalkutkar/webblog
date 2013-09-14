class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :photo, :class_name => Photo, foreign_key: "uid"
  has_many :bids, foreign_key:"uid" ,:class_name => Bid

end
