require 'pusher'
Pusher.app_id = ENV['APP_ID']
Pusher.key = ENV['APP_KEY']
Pusher.secret = ENV['APP_SECRET']

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
  @jabrs = Jabr.all
  @users = User.all
  erb :"jabrs/index"
end

post '/jabrs' do
  if Jabrs.between(params[:sender_id], params[:recipient_id]).present?
    @jabr = Jabr.between(params[:sender_id], params[:recipient_id]).first
  else
    @jabr = Jabr.create(sender_id: current_user.id, recipient_id: 1)
  end
  redirect "/jabrs/#{@jabr.id}/messages"
end

get '/jabrs/:id/messages' do
  @jabr = Jabr.find(params[:id])
  @messages = @jabr.messages
  # @recipient = User.find(@jabr.sender_id)

  erb :"jabrs/show"
end

post '/jabrs/:id/messages' do
  @message = Message.create(user_id: current_user.id, body: params[:message], jabr_id: params[:id])
  options = {
    message: @message.body,
    username: current_user.username
  }
  Pusher['chat_channel'].trigger('new_message', options)
  "success".to_json
end