class User < ActiveRecord::Base
  has_many :photo, :class_name => Photo
end
