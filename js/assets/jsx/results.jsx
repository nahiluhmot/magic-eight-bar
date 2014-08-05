/** @jsx React.DOM */

var Views = Views || {};

Views.Results = React.createClass({
  getInitialState: function() {
    return { bar: {} };
  },

  componentWillMount: function() {
    getNextPreduction();
  },

  getNextPreduction: function() {
    var component = this;

    reqwest({
      url: '/api/predictions/',
      method: 'GET',
      type: 'json',
      error: function() {
        console.log('Error getting next prediction');
      },
      success: function(bar) {
        component.setState({ bar: bar });
      }
    });
  },

  render: function() {
    return (
      <div className="container-fluid fix-margin top-level">
        <h1>Results</h1>

        <div className="row">
          <p className="lead">You should go to: {this.state.bar.name}!</p>
        </div>

        <div className="row">
          <div className="col-lg-6">
          </div>

          <div className="col-lg-6">
          </div>
        </div>

      </div>
    );
  }
});
