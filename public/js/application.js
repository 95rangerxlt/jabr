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
});
