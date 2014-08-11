/**
 * The Bars object handles interactions with the server that deal with bars.
 * This object has a 1:1 mapping to the BarsController on the backend.
 */
var Bars = {
  /**
   * Get the list of every bar. 
   *
   * options:
   *   success: callback that is given the list of bars; executed when the
   *            request succeeds.
   *   error:   callback that is given an HTTP error; executed when the request
   *            fails.
   */
  list: function(options) {
    options = options || {};
    options.url = '/api/bars';
    options.method = 'GET';
    options.type = 'json';

    reqwest(options);
  }
};
