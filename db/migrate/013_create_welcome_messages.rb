class CreateWelcomeMessages < ActiveRecord::Migration
  def self.up
    create_table :welcome_messages do |t|
      t.column :body, :text
      t.column :created, :timestamp
    end
    
    WelcomeMessage.create(
      :body=>'<h1>Welcome to Peeoutside.org!</h1>
      <p>
      Did you know that the average toilet wastes three gallons of water per flush? 
      </p>
      <p>
      <a href="/">Peeoutside.org</a>
      was founded in 2007 in Atlanta, Georgia, in response to the state\'s worst drought in recorded history.  Our goal is to promote a simple, yet seldom talked about way to ease water consumption. With a current population of 5,138,223 in the metro area, Atlanta could save over 15 million gallons of water per day – simply by peeing outside once a day.
      </p>
      <p>
      The movement is not, however, limited to Georgians – or even Southeasterners; all bathroom goers are welcome and encouraged to conserve water by urinating outside at least once daily.
      </p>
      <p>
      If you are a bathroom goer who wants to make a difference, 
      <a href="/pee/signup">join us!</a>
      All you need to do is 
      <a href="/pee/signup">submit your information</a>
      and pledge to pee outside an average of once per day.
      </p>
      <p>
      <a href="/pee/faq">Check out our FAQs</a>
      for more information. You can also participate by 
      <a href="/upload">sending us your story or picture</a>
      – but keep the pictures clean, please.
      </p>
      <p>
      Thanks for stopping by!
      </p>
      '
    )
  end

  def self.down
    drop_table :welcome_messages
  end
end
