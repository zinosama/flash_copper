require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt
  has_many :histories


  validates :username, presence: true, uniqueness: true
  validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def compile_deck_histories
    histories = History.where("user_id = ?", self.id).order(updated_at: :asc)
    result_hash = {}
    histories.each do |history|
      if result_hash.key?(Deck.find(history.deck_id).name)
        result_hash[Deck.find(history.deck_id).name] << history
      else
        result_hash[Deck.find(history.deck_id).name] = [history]
      end
    end
    result_hash
  end
end
