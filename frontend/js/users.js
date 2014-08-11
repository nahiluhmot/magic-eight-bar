/**
 * The Users object handles interactions with the server that deal with users.
 * This object has a 1:1 mapping to the UsersController. on the backend.
 */
var Users = {
  /**
   * Create a new user. The user's session will be set as the 'id' cookie.
   *
   * options:
   *   success: callback that is given the new user; executed when the request
   *            succeeds.
   *   error:   callback that is given an HTTP error; executed when the request
   *            fails.
   */
  create: function(options) {
    options = options || {};

    options.url = '/api/users/';
    options.method = 'POST';
    options.type = 'json';

    reqwest(options);
  },

  /**
   * Test if the logged in user has a valid cookie.
   *
   * options:
   *   success: callback that is given the HTTP response; executed when the
   *            request succeeds.
   *   error:   callback that is given an HTTP error; executed when the request
   *            fails.
   */
  valid: function(options) {
    options = options || {};

    options.url = '/api/users/valid';
    options.method = 'GET';

    reqwest(options);
  }
};
