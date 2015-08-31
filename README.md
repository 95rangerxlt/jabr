# jabr
Coding challenge for Rhumbix

Credits:
Tiny Responsive Grid by Josh Marsh: http://jkymarsh.com
Pusher: http://pusher.com
DB Associations/validations: https://medium.com/@danamulder/tutorial-create-a-simple-messaging-system-on-rails-d9b94b0fbca1

Update: MVP has some bugs I will be fixing:
-only one socket open, so messages from other jabrs will update on all active jabrs. oops! will fix by assigning jabr-specific events to pusher
-styling is terrible. would like to fix that. mobile view is not set, and messages prepend too low
-sessions delete route was done in haste, needs to be made RESTful, and split files for the controllers will be made
-there is currently no testing
-login-specific debugging is needed