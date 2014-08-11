/**
 * The Predictions object handles interactions with the server that deal with
 * predictions. This object has a 1:1 mapping to the PredictionsController on
 * the backend.
 */
var Predictions = {
  /**
   * Get the next prediction for the logged in user.
   *
   * options:
   *   success: callback that is given the next prediction; executed when the
   *            request succeeds.
   *   error:   callback that is given an HTTP error; executed when the request
   *            fails.
   */
  next: function(options) {
    options = options || {};

    options.url = '/api/predictions/';
    options.method = 'GET';
    options.type = 'json';

    reqwest(options);
  }
};
