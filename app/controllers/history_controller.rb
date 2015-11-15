#---------HIstory controller
get '/decks/:deck_id/histories/new' do
  new_history = History.create(user_id:session[:id],deck_id:params[:deck_id])
  new_card_id = new_history.deck.cards.first.id
  redirect "/histories/#{new_history.id}/guesses/new?new_card_id=#{new_card_id}"
end

#---------Guess controller
get '/histories/:history_id/guesses/new' do
  @history=History.find(params[:history_id])
  if params[:new_card_id]
    @new_guess=Guess.new(card_id:params[:new_card_id],history_id:params[:history_id],first_round:true)
    @new_guess.save
    erb :'guesses/show'
  else
    card = @history.new_card
    if !card
      @result=@history.compile_result
      erb :'histories/show'
    else

      if @history.check_first_round
        @new_guess=Guess.new(card_id:card.id,history_id:params[:history_id],first_round:true)
      else
        @new_guess=Guess.new(card_id:card.id,history_id:params[:history_id],first_round:false)
      end
      @new_guess.save
      erb :'guesses/show'
    end

  end

end

post '/guesses/:guess_id/check' do
  user_input=params[:user_input] #!!!url params to be implemented
  @guess=Guess.find(params[:guess_id])
  if @guess.card.answer.downcase==user_input.downcase.strip #do we need card.first?
    @guess.correct=true
    @output="Correct. Click next to move on."
  else
    @guess.correct=false
    @output="Wrong. The right answer is #{@guess.card.answer}. Click next to move on."
  end
    @guess.save
    erb :"guesses/result" #this will pass on history id
end

post '/guesses/:guess_id/result' do
  guess = Guess.find(params[:guess_id])
  history_id = guess.history_id
  redirect "/histories/#{history_id}/guesses/new"
end
