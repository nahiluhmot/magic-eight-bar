// The Bars object handles interactions with the server that deal with bars.
var Bars = {
  list: function(options) {
    options = options || {};
    options.url = '/api/bars';
    options.method = 'GET';
    options.type = 'json';

    reqwest(options);
  }
};
