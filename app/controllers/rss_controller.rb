class RssController < ApplicationController
  def news
    @newsitems = Newsitem.find(:all, :order=>'created desc')
    render :layout=>false
  end
end
