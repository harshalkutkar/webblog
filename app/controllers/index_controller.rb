class IndexController < ApplicationController

  def welcome
       @photos = Photo.all.limit(3);

  end
end
