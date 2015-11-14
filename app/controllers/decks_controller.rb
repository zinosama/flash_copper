get '/decks' do
  @decks = Deck.all

  erb :'decks/index'
end



get '/decks/:deck_id' do
  @deck = Deck.find(params[:deck_id])
  if params[:f_t]
    if params[:index].to_i==@deck.cards.length
      @i_a=params[:i_a].split(',')
      @a_a=params[:a_a].split(',')
      if params[:f_t]=="correct"
        @f_t="wrong"
        # f_g_c=@deck.cards.length - @i_a.length
        # Game.new(first_guess_correct:f_g_c)
      end
      @a_a=@i_a.join(',')
      @i_a=""
      @index=0
    else
      @a_a=params[:a_a]
      @index=params[:index].to_i
      @i_a=params[:i_a]
      @f_t=params[:f_t]
    end
  else
    @index=0
    @f_t="correct"
    @i_a=""#incorrect aray
    @a_a=""
    @deck.cards.each do |card|
      @a_a = @a_a + ','+card.id.to_s
    end
    @a_a=@a_a[1..-1]
  end
  @card=Card.find(@a_a.split(',')[@index])

  erb :'decks/show'
end
