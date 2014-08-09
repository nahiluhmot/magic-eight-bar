/** @jsx React.DOM */

var Views = Views || {};

Views.Map = React.createClass({
  // Prop logic
  propTypes: {
    id: React.PropTypes.string.isRequired,
    lat: React.PropTypes.number.isRequired,
    lon: React.PropTypes.number.isRequired,
    zoom: React.PropTypes.number.isRequired,
    options: React.PropTypes.object.isRequired,
    style: React.PropTypes.string.isRequired,
    marker: React.PropTypes.string
  },

  getDefaultProps: function() {
    return { zoom: 15, options: {}, style: {} };
  },

  getDefaultState: function() {
    return { map: null };
  },

  // Lifecyce events
  componentDidMount: function() {
    var div     = this.getDOMNode(),
        options = this.getOptions(),
        map     = new google.maps.Map(div, options);

    if(this.props.marker) {
      new google.maps.Marker({
        position: this.mapCenter(),
        map: map,
        title: this.props.marker
      });
    }
  },

  // Utility functions

  getOptions: function() {
    var options = this.props.options;

    options.center = this.mapCenter();
    options.zoom = this.props.zoom;

    return options;
  },

  mapCenter: function() {
    return new google.maps.LatLng(this.props.lat, this.props.lon);
  },

  // Called to show the HTML of this component.
  render: function() {
    return <div className="map img-responsive" style={this.props.style} />;
  }
});
