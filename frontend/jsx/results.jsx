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
            style: { height: '500px' },
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
        <div className="col-sm-4">
          <button href="/reviews"
                  className="btn btn-lg btn-danger"
                  onClick={this.handleClick(-1)}>
            Nah
          </button>
        </div>

        <div className="col-sm-4">
          <button href="/reviews"
                  className="btn btn-lg btn-warning"
                  style={{ background: "#e6a62a", borderColor: "#e6a62a" }}
                  onClick={this.handleClick(0)}>
            Skip
          </button>
        </div>

        <div className="col-sm-4">
          <button href="/reviews"
                  className="btn btn-lg btn-success"
                  onClick={this.handleClick(1)}>
            Yup
          </button>
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
