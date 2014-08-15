/** @jsx React.DOM */

var Views = Views || {};

/**
 * This view handles the results page.
 */
Views.Results = React.createClass({
  /**
   * Initially, there is no bar.
   */
  getInitialState: function() {
    return { bar: {} };
  },

  /**
   * Get the next prediction after the component mounts.
   */
  componentDidMount: function() {
    this.getNextPrediction();
  },

  /**
   * Get the next prediction, updating the state upon success.
   */
  getNextPrediction: function() {
    var component = this;

    Predictions.next({
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

  displaySuccess: function() {
    var bar = this.state.bar;

    this.setState({
      helpText: (
        <p className="text-center lead">
          Glad we could help! Visit&nbsp;
          <a href={bar.website} target="_blank">
            {bar.name}'s website
          </a>? Get&nbsp;
          <a href={"https://maps.google.com?daddr=" + encodeURIComponent(bar.address)}
             target="_blank">
            directions
          </a>?
        </p>
      )
    });
  },

  handleClick: function(rating) {
    var component = this,
        success = (rating === 1) ? this.displaySuccess : this.getNextPrediction;

    return (function(e) {
      e.preventDefault();

      Reviews.create({
        bar: component.state.bar,
        rating: rating,
        success: success
      });
    });
  },

  /**
   * Render the header.
   */
  renderHeader: function() {
    var bar = this.state.bar;
    if(bar) {
      return (
        <div className="row text-center">
          <h3>
            Signs point to: <a href={bar.website} target="_blank">{bar.name}</a>
          </h3>
          <p className="lead">{bar.address}</p>
        </div>
      );
    }
  },

  /**
   * Render the map.
   */
  renderMap: function() {
    if(this.state.map) {
      return (<div className="row">{this.state.map}</div>);
    }
  },

  /**
   * Render the buttons or help text.
   */
  renderButtons: function() {
    if(this.state.helpText) {
      return (
        <div className="row">
          {this.state.helpText}
        </div>
      );
    } else {
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
    }
  },

  /**
   * Render the results page.
   */
  render: function() {
    return (
      <div className="container-fluid top-level fix-margin">

        {this.renderHeader()}
        {this.renderMap()}

        <br />

        {this.renderButtons()}

      </div>
    );
  }
});
