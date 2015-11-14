get '/cards/result' do
  deck = Deck.find(params[:deck_id])
  @deck_id=deck.id
  if params[:answer].downcase == params[:guess].downcase.strip
    @output="Success, click continue to proceed to next question!"
    @i_a=params[:i_a]
  else
    @output="Ooooops!~Wrong! The correct answer is #{params[:answer]}. Click next to proceed!"
    a_a=params[:a_a].split(',')
    @i_a=params[:i_a]
    if @i_a==""
      @i_a=a_a[params[:index].to_i]
    else
      @i_a=params[:i_a]+","+a_a[params[:index].to_i]
    end
  end

  @index=params[:index].to_i+1

  erb :'cards/result'
end
