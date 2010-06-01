class PagesController < ApplicationController
  @@base_title = "Stabilisers - "
  
  def home
    @title = @@base_title + 'Home'
  end

  def contact
    @title = @@base_title + 'Contact'
  end
  
  def about
    @title = @@base_title + 'About'
  end

end
