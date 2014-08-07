// The User object handles interactions with the server that deal with users.
var Users = {
  create: function(options) {
    options = options || {};

    options.url = '/api/users/';
    options.method = 'POST';
    options.type = 'json';

    reqwest(options);
  }
};
