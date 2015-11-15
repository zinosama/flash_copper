get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  user=User.find_by(username:params[:username])
  if user && user.password == params[:password]
    session[:id]=user.id
    session[:username]=user.username
    redirect '/'
  else
    redirect '/sessions/new?error=wrong_username_password_combo'
  end
end

get '/sessions/logout' do
  session.clear
  redirect '/'
end
