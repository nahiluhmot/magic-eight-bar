/**
 * The Reviews object handles interactions with the server that deal with
 * reviews. This object has a 1:1 mapping to the ReviewsController on the
 * backend.
 */
var Reviews = {
  /**
   * Create a new review for the logged in user.
   *
   * options:
   *   bar:     the bar to review.
   *   rating:  the rating the user gave the bar. must be -1, 0, or 1.
   *   success: callback that is given the new review; executed when the request
   *            succeeds.
   *   error:   callback that is given an HTTP error; executed when the request
   *            fails.
   */
  create: function(options) {
    options = options || {};

    var bar = options.bar,
        rating = options.rating;

    delete options.bar;
    delete options.rating;

    options.data = { bar_id: bar.id, rating: rating };
    options.method = 'POST';
    options.type = 'json';
    options.url = '/api/reviews';

    reqwest(options);
  }
};
