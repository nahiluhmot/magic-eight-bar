/** @jsx React.DOM */

var Views = Views || {};

Views.Results = React.createClass({
  getInitialState: function() {
    return {};
  },

  getQueryParams: function() {
    var query  = window.location.search.substring(1),
        result = {};

    query.split('&').forEach(function(keyVal) {
      var pair = keyVal.split('='),
          match = pair[0].match(/^(.*)\[\]$/);

      if(match === null) {
        result[pair[0]] = pair[1];
      } else {
        result[match[1]] = result[match[1]] || [];
        result[match[1]].push(pair[1]);
      }
    });

    return result;
  },

  getMatchingBar: function(places) {
  }

  render: function() {
    return (
      <div className="container-fluid fix-margin top-level">
        <h1>Results</h1>

        <div className="row">
          <div className="col-lg-6">
            <p className="lead">You should go to: {this.state.bar}!</p>
          </div>

          <div className="col-lg-6">
          </div>

        </div>
      </div>
    );
  }
});
