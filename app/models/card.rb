class Card < ActiveRecord::Base
  # Remember to create a migration!
  has_many :guesses
  belongs_to :deck
  has_many :histories, through: :guesses

end
