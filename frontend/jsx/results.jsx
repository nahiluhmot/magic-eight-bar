/** @jsx React.DOM */

var Views = Views || {};

Views.Results = React.createClass({
  getInitialState: function() {
    return { bar: {} };
  },

  componentWillMount: function() {
    this.getNextPrediction();
  },

  getNextPrediction: function() {
    var component = this;

    Predictions.next({
      error: function() {
        console.log('Error getting next prediction');
      },
      success: function(bar) {
        component.setState({ bar: bar });
      }
    });
  },

  renderMap: function() {
    if(this.state.bar.lat && this.state.bar.lon) {
      return Views.Map({
        id: 'prediction-map',
        lat: Number(this.state.bar.lat),
        lon: Number(this.state.bar.lon),
        style: { height: '500px' },
        marker: this.state.bar.name
      });
    }
  },

  render: function() {
    return (
      <div className="container-fluid top-level fix-margin">
        <div className="row text-center">
          <h3>{this.state.bar.name}</h3>
        </div>

        <div className="row">
          <div className="col-lg-6">
            {this.renderMap()}
          </div>
        </div>
      </div>
    );
  }
});
