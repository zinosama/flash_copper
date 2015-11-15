get '/' do
  @user=User.find(session[:id]) if session[:id]
  @decks=Deck.all
  erb :'decks/index'
end
