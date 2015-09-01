require 'pusher'
Pusher.app_id = ENV['APP_ID']
Pusher.key = ENV['APP_KEY']
Pusher.secret = ENV['APP_SECRET']

###########      Log In / Create User / Log Out   #############
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


get '/sessions/delete' do
  log_out
  redirect '/'
end


###########      Jabr Controller     #############
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

  erb :"jabrs/show"
end



post '/jabrs/:id/messages' do
  @message = Message.create(user_id: current_user.id, body: params[:message], jabr_id: params[:id])
  options = {
    message: @message.body,
    username: current_user.username
  }

  Pusher[params['jabr-channel']].trigger('new_message', options)
  "success".to_json
end



get '/users/:id' do
  @jabrs = Jabr.where("recipient_id = ? OR sender_id = ?", current_user.id, current_user.id)
  @jabr = nil
  other_user_id = params[:id].to_i

  if @jabrs.length == 0
    @jabr = Jabr.create(sender_id: current_user.id, recipient_id: other_user_id)
    redirect "/jabrs/#{@jabr.id}/messages"
  end

  @jabrs.each do |jabr|
    if jabr.recipient_id == other_user_id || jabr.sender_id == other_user_id
      redirect "/jabrs/#{jabr.id}/messages"
    end
  end

  @jabr = Jabr.create(sender_id: current_user.id, recipient_id: params[:id])
  redirect "/jabrs/#{@jabr.id}/messages"
end