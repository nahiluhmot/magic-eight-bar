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
    if (this.props.active == key) {
      return function (e) { e.preventDefault(); };
    } else {
      return function (e) {
        e.preventDefault();
        Aviator.navigate(Tabs[key]);
      }
    }
  },

  renderKey: function(key) {
    if (this.props.active == key) {
      return (
        <li className="active">
          <a href={Tabs[key]} onClick={this.handleClick(key)}>{key}</a>
        </li>
      );
    } else {
      return (
        <li>
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
            <button type="button" className="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
              <span className="sr-only">Toggle navigation</span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
              <span className="icon-bar"></span>
            </button>
            <a className="navbar-brand" href="/" onClick={this.handleClick('Home')}>Magic Eight Bar</a>
          </div>

          <div className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul className="nav navbar-nav">
              {Object.keys(Tabs).map(this.renderKey)}
            </ul>
          </div>
        </div>
      </nav>
    );
  }
});
