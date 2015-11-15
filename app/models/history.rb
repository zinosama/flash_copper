class History < ActiveRecord::Base
  # Remember to create a migration!
  has_many :guesses
  has_many :cards, through: :guesses
  belongs_to :user
  belongs_to :deck

  def new_card
    if check_first_round
      available_cards = self.deck.cards - self.cards
      return available_cards[rand(0..available_cards.length-1)]
    else
      unavailable_cards=[]
      self.guesses.each do |guess|
        if !unavailable_cards.include?(guess.card) && guess.correct
          unavailable_cards.push(guess.card)
        end
      end
      available_cards = self.deck.cards - unavailable_cards
      if available_cards.length==0
        return false
      else

        return available_cards[rand(0..available_cards.length-1)]
      end
    end
  end

  def check_first_round
    self.guesses.length < self.deck.cards.length
  end

  def compile_result
    first_correct=0
    guesses=self.guesses
    guesses.each{|guess| first_correct+=1 if guess.correct && guess.first_round}

    total_attempts=self.guesses.length

    output={first_correct:first_correct,total_attempts:total_attempts}
  end

end
