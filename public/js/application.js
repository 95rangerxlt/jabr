$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $('#login').on('click', function(e){
    e.preventDefault();
    console.log('login button clicked');
    $('#logins').hide();
    $('#login-container').show();
  })

  $('#register').on('click', function(e){
    e.preventDefault();
    console.log('register button clicked');
    $('#logins').hide();
    $('#register-container').show();
  })

  $('#login-link').on('click', function(e){
    e.preventDefault();
    $('#register-container').hide();
    $('#login-container').show();
  })

  $('#register-link').on('click', function(e){
    e.preventDefault();
    $('#login-container').hide();
    $('#register-container').show();
  })

  var pusher = new Pusher('529cb21eacc7a9f5e30a');
  var chatWidget = new PusherChatWidget(pusher, {
    // chatEndPoint: 'pusher-realtime-chat-widget/src/php/chat.php'
  });
  var channel = pusher.subscribe('chat_channel');
  channel.bind('new_message', function(data) {
    $('#history').append("<p>" + data.username + " jabr'd " + data.message + "</p>")
  });

  $('#chat-form').on('submit', function(e){
    e.preventDefault();
    var chatSubmit = $.ajax({
      url: $(this).attr('action'),
      method: 'post',
      dataType: 'json',
      data: $(this).serialize()
    })
    chatSubmit.done(function(response){
      console.log("SUCCESS")
      console.log(response)
      $('#chat-input').val('');
    })
    chatSubmit.fail(function(response){
      console.log("FAIL")
      console.log(response)
    })
  })
});
