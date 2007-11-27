class PopulateFaqs < ActiveRecord::Migration
  def self.up
    Faq.delete_all
    Faq.create(
      :position=>1,
      :title=>'Are you actually serious about this?',
      :body=>'Why not?  Millions of gallons of water are wasted each day by people who could simply be peeing outside.  Think about it, there are over 2.5 million men in the Atlanta metro area alone.  If each man peed outside once a day, it would mean real water savings.'
    )
    Faq.create(
      :position=>2,
      :title=>'How many gallons is the typical toilet flush?',
      :body=>'According to the United States Geological Survey, each flush is an average of 3 gallons.  (<a href="http://www.usgs.gov/" target="_blank">USGS</a>)'
    )
    Faq.create(
      :position=>3,
      :title=>'Are you suggesting that people expose themselves in public?',
      :body=>'No.  Just so we are clear, the suggestion is that people pee on their own property, in a private setting, preferably under the cover of night.'
    )
    Faq.create(
      :position=>4,
      :title=>'Should people fully abandon use of toilet for the purposes of urination?',
      :body=>'Not at all.  We realize that many people will not have the chance to pee outside.  We just ask that people pee outside when they have the opportunity.'
    )
    Faq.create(
      :position=>5,
      :title=>'What other types of animals pee outside?',
      :body=>'As far as we know, humans are the only species that insist on peeing inside, with the exception of house cats, but thats a whole other issue.'
    )
    Faq.create(
      :position=>6,
      :title=>'How can I support Peeoutside.org?',
      :body=>'Sign up.  We\'re not going to spam you, but you might get a newsletter every now and then.  We have also designed some t-shirts.  Let us know if you are interested in purchasing one of them, and what size you\'d want.  We\'ll contact you as soon as we make them.  Let us know if there is some other type of merchandise that you\'d like to have.  You can also join our <a href="http://www.facebook.com/group.php?gid=5694249711">Facebook group.</a>'
    )
    Faq.create(
      :position=>7,
      :title=>'Is pee bad for the Earth?',
      :body=>'Nope.  Pee can be used in gardening as a organic fertilizer.  Its best to aim away from plants, as it can burn the roots of some types (pee has a high concentration of nitrogen).  If you are looking for an ideal place to pee, do it on a compost pile, the nitrogen gives it more nutrients.'
    )
  end

  def self.down
  end
end
