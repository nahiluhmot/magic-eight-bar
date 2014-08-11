/** @jsx React.DOM */

var Views = Views || {};

/**
 * This is a re-usable component whose purpose is to show a Google Map. To
 * ensure immutability, this component only uses props and no state.
 */
Views.Map = React.createClass({
  /* Prop logic */

  /**
   * This object allows the component to have statically-typed props.
   */
  propTypes: {
    // The DOM id of this component.
    id: React.PropTypes.string.isRequired,
    // The latitude which the map should visit.
    lat: React.PropTypes.number.isRequired,
    // The longitude which the map should visit.
    lon: React.PropTypes.number.isRequired,
    // The amount of zoom on the map.
    zoom: React.PropTypes.number.isRequired,
    // Extra sytling for the map.
    style: React.PropTypes.string.isRequired,
    // The name of the marker to place on the map, if any.
    marker: React.PropTypes.string,
    // Extra options to render the map.
    options: React.PropTypes.object.isRequired
  },

  /**
   * Get the default set of props if none are provided.
   */
  getDefaultProps: function() {
    return { zoom: 15, options: {}, style: {} };
  },

  /* Lifecyce events */

  /**
   * Once this component is mounted on the DOM, create the map and place the
   * marker.
   */
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

  /* Utility functions */

  /**
   * Interpolate other props with the given options.
   */
  getOptions: function() {
    var options = this.props.options;

    options.center = this.mapCenter();
    options.zoom = this.props.zoom;

    return options;
  },

  /**
   * Return a google.maps.LatLng containing the component's latitude and longitude.
   */
  mapCenter: function() {
    return new google.maps.LatLng(this.props.lat, this.props.lon);
  },

  /* Main function */

  /**
   * Render an empty div on which the map will be placed.
   */
  render: function() {
    return <div id={this.props.id} className="map img-responsive" style={this.props.style} />;
  }
});
