#---------Card controller
get '/cards/:card_id' do
  @card=Card.find(params[:card_id])
  erb :'cards/show'
end


#---------HIstory controller
get '/decks/:deck_id/histories/new' do
  if session[:id]
    new_history = History.create(user_id:session[:id],deck_id:params[:deck_id])
    new_card_id = new_history.deck.cards.first.id
    redirect "/histories/#{new_history.id}/guesses/new?new_card_id=#{new_card_id}"
  else
    redirect '/sessions/new'
  end
end

delete '/histories/:history_id/delete' do
  history=History.find(params[:history_id])
  history.destroy
  redirect "/users/histories"
end

get '/histories/:history_id/guesses' do
  history=History.find(params[:history_id])
  @guesses=history.guesses
  erb :'histories/show'
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
      @history.finished=true
      @history.save
      erb :'histories/success'
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
    @output="<p class='guess_result'>CORRECT</p><p class='guess_instruction'>Click next to move on</p>"
  else
    @guess.correct=false
    @output="<p class='guess_result'>WRONG</p><p class='guess_instruction'> The right answer is <span class='guess_right_answer'>#{@guess.card.answer}</span>. Click next to move on.</p>"
  end
    @guess.save
    erb :"guesses/result" #this will pass on history id
end

post '/guesses/:guess_id/result' do
  guess = Guess.find(params[:guess_id])
  history_id = guess.history_id
  redirect "/histories/#{history_id}/guesses/new"
end
