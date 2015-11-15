get '/users/new' do
  erb :'users/new'
end

post '/users' do
  user=User.new(params)
  if user.valid?
    user.save
    session[:id]=user.id
    redirect '/'
  else
    errors=user.errors.full_messages
    redirect "/users/new?error=#{errors}"
  end
end

get '/users/histories' do
  @user = User.find(session[:id])
  @histories = @user.compile_deck_histories

  erb :'users/show'
end
