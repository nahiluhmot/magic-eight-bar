/** @jsx React.DOM */

var Views = Views || {};

/**
 * This immutable class renders the navbar for the appication.
 */
Views.Nav = React.createClass({
  /**
   * Set the propTypes for a statically-typed component.
   */
  propTypes: {
    // The active tab in the navbar.
    active: React.PropTypes.string.isRequired
  },

  /**
   * This object is a mapping of the navbar text to which route they should go
   * to.
   */
  tabs: {
    Home: "/",
    About: "/about",
    Legal: "/legal",
    Contact: "/contact"
  },

  /**
   * When a link is clicked in the navbar, tell Aviator which route to render.
   */
  handleClick: function(key) {
    var component = this;
    return function(e) {
      e.preventDefault();
      Aviator.navigate(component.tabs[key]);
    };
  },

  /**
   * Render the given key. If the key is active, set the correct CSS class for
   * the list element.
   */
  renderKey: function(key) {
    return (
      <li key={key} className={(this.props.active === key) ? 'active' : null}>
        <a href={this.tabs[key]} onClick={this.handleClick(key)}>{key}</a>
      </li>
    );
  },

  /**
   * Render the navbar.
   */
  render: function() {
    return (
      <nav className="navbar navbar-default navbar-fixed-top">
        <div className="container-fluid">
          <div className="navbar-header">
            <a className="navbar-brand"
               href="/"
               onClick={this.handleClick('Home')}>
              Magic 8 Bar
            </a>
          </div>

          <div className="collapse navbar-collapse">
            <ul className="nav navbar-nav">
              {Object.keys(this.tabs).map(this.renderKey)}
            </ul>
          </div>
        </div>
      </nav>
    );
  }
});
