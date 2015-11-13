class Deck < ActiveRecord::Base
  has_many :games
  has_many :cards

  validates :name, presence: true, uniqueness: true
end
