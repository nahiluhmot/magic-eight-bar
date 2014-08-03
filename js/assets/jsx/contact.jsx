/** @jsx React.DOM */

var Views = Views || {};

Views.Contact = React.createClass({
  handleClick: function(e) {
    e.preventDefault();
    window.open('mailto:magic8bar@gmail.com');
  },

  render: function() {
    return (
      <div className="container">
        <h1>Contact</h1>

        <p className="lead">
          Feel free to send any comments, question, suggestions, or bug reports
          to <a href="#" onClick={this.handleClick}>magic8bar@gmail.com</a>.
        </p>
      </div>
    );
  }
});
