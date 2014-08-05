var Utils = Utils || {
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
