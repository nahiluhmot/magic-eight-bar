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
        component.setState({ map: null });
        component.setState({
          bar: bar,
          helpText: null,
          map: Views.Map({
            id: 'prediction-map',
            lat: Number(bar.lat),
            lon: Number(bar.lon),
            style: { height: '500px', width: '100%', display: 'block', margin: 'auto' },
            marker: bar.name
          })
        });
      }
    });
  },

  handleClick: function(rating) {
    var component = this;

    return (function(e) {
      e.preventDefault();
      Reviews.create({
        bar: component.state.bar,
        rating: rating,
        success: component.getNextPrediction,
        error: function() {
          component.setState({
            helpText: "Error communicating with server, please try again later"
          });
        }
      });
    });
  },

  renderHeader: function() {
    if(this.state.bar) {
      return (
        <div className="row text-center">
          <h3>
            Signs point to: &nbsp;
            <a href={this.state.bar.website} target="_blank">
              {this.state.bar.name}
            </a>
          </h3>
          <p className="lead">{this.state.bar.address}</p>
        </div>
      );
    }
  },

  renderHelpText: function() {
    if(this.state.helpText) {
      return (
        <div className="row">
          <div className="col-lg-12">
            {this.state.helpText}
          </div>
        </div>
      );
    }
  },

  renderMap: function() {
    if(this.state.map) {
      return (
        <div className="row">
          <div className="col-lg-12">
            {this.state.map}
          </div>
        </div>
      );
    }
  },

  renderButtons: function() {
    return (
      <div className="row text-center">
        <div className="col-sm-4 pull-left">
          <a style={{ color: '#c0392b' }}
             className="lead"
             href="/reviews"
             onClick={this.handleClick(-1)}>
            Very Doubtful
          </a>
        </div>

        <div className="col-sm-4">
          <a style={{ color: '#f1c40f' }}
             className="lead"
             href="/reviews"
             onClick={this.handleClick(0)}>
            Maybe Later
          </a>
        </div>

        <div className="col-sm-4 pull-right">
          <a style={{ color: '#27ae60' }}
             className="lead"
             href="/reviews"
             onClick={this.handleClick(1)}>
            It Is Certain
          </a>
        </div>
      </div>
    );
  },

  render: function() {
    return (
      <div className="container-fluid top-level fix-margin">

        {this.renderHeader()}
        {this.renderHelpText()}
        {this.renderMap()}

        <br />

        {this.renderButtons()}

      </div>
    );
  }
});
