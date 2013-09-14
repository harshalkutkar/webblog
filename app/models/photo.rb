class Photo < ActiveRecord::Base
  belongs_to :user, :class_name => User
  has_many :bids, foreign_key:"pid" ,:class_name => Bid
end
