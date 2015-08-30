get '/' do
  erb :login
end

post '/users' do
  @user = User.create(username: params[:username], password: params[:password])
  log_in(@user)
  redirect '/jabrs'
end

post '/sessions' do
  @user = User.find_by(username: params[:username])
  if @user && @user.password == (params[:password])
    log_in(@user)
    redirect '/jabrs'
  else
    redirect '/'
  end
end

get '/jabrs' do
  erb :"jabrs/index"
end