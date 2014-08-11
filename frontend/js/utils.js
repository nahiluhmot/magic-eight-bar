/**
 * This object contains miscellanous functions not related to any other
 * object/module.
 */
var Utils = {
  /**
   * Get the cookies stored in the browser.
   *
   * returns: a hash mapping the cookie key to its value.
   */
  getCookies: function() {
    var cookies = {};

    document.cookie.split(';').forEach(function(pair) {
      var keyVal = pair.split('='),
          key = keyVal[0],
          val = keyVal[1];

      cookies[key] = val;
    });

    return cookies;
  }
}
