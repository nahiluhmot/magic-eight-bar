/** @jsx React.DOM */

var Views = Views || {};

var Tabs = Tabs || {
  Home: "/",
  About: "/about",
  Legal: "/legal",
  Contact: "/contact"
};

Views.Nav = React.createClass({
  handleClick: function(key) {
    return function(e) {
      e.preventDefault();
      Aviator.navigate(Tabs[key]);
    };
  },

  renderKey: function(key) {
    if (this.props.active == key) {
      return (
        <li key={key} className="active">
          <a href={Tabs[key]} onClick={this.handleClick(key)}>{key}</a>
        </li>
      );
    } else {
      return (
        <li key={key}>
          <a href={Tabs[key]} onClick={this.handleClick(key)}>{key}</a>
        </li>
      );
    }
  },

  render: function() {
    return (
      <nav className="navbar navbar-default">
        <div className="container-fluid">
          <div className="navbar-header">
            <a className="navbar-brand" href="/" onClick={this.handleClick('Home')}>Magic Eight Bar</a>
          </div>

          <div className="collapse navbar-collapse">
            <ul className="nav navbar-nav">
              {Object.keys(Tabs).map(this.renderKey)}
            </ul>
          </div>
        </div>
      </nav>
    );
  }
});
