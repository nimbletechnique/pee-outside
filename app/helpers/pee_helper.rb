module PeeHelper

  def pee_stats
    @pledges = Signup.find(:all, :conditions=>'pledged = true')
    "Thanks to your pledges we are now saving <b>#{@pledges.size * 3}</b> gallons a day!"
  end
  
end
