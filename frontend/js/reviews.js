// The Reviews object handles interactions with the server that deal with reviews.
var Reviews = {
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
