class PagesController < ApplicationController
  def home
    @title = 'Stabilisers - Home'
  end

  def contact
    @title = 'Stabilisers - Contact'
  end
  
  def about
    @title = 'Stabilisers - About'
  end

end
