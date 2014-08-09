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
        component.setState({ bar: bar, helpText: null });
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

  renderHelpText: function() {
    if ((typeof this.state.helpText) === 'string') {
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
    if(this.state.bar.lat && this.state.bar.lon) {
      return (
        <div className="row">
          <div className="col-lg-12">
            {
              Views.Map({
                id: 'prediction-map',
                lat: Number(this.state.bar.lat),
                lon: Number(this.state.bar.lon),
                style: { height: '500px' },
                marker: this.state.bar.name
              })
            }
          </div>
        </div>
      );
    }
  },

  renderButtons: function() {
    return (
      <div className="row pull-center">
        <div className="col-sm-4">
          <button href="/reviews"
                  className="btn btn-lg btn-error"
                  onClick={this.handleClick(-1)}>
            Nah
          </button>
        </div>

        <div className="col-sm-4">
          <button href="/reviews"
                  className="btn btn-lg btn-primary"
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

  renderHeader: function() {
    return (
      <div className="row text-center">
        <h3>{this.state.bar.name}</h3>
      </div>
    );
  },

  render: function() {
    return (
      <div className="container-fluid top-level fix-margin">

        {this.rendreHeader()}
        {this.renderHelpText()}
        {this.renderMap()}
        {this.renderButtons()}

      </div>
    );
  }
});
