// The User object handles interactions with the server that deal with
// predictions.
var Predictions = {
  next: function(options) {
    options = options || {};

    options.url = '/api/predictions/';
    options.method = 'GET';
    options.type = 'json';

    reqwest(options);
  }
};
