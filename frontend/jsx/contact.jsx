/** @jsx React.DOM */

var Views = Views || {};

/**
 * This component handles logic for the '/contact' route.
 */
Views.Contact = React.createClass({
  /**
   * When the link to magic8bar@gmail.com is clicked, open the user's email client.
   */
  handleClick: function(e) {
    e.preventDefault();
    window.open('mailto:magic8bar@gmail.com');
  },

  /**
   * Render the contact page.
   */
  render: function() {
    return (
      <div className="container top-level fix-margin">
        <h1>Contact</h1>

        <p className="lead">
          Feel free to send any comments, question, suggestions, or bug reports
          to <a href="#" onClick={this.handleClick}>magic8bar@gmail.com</a>.
        </p>
      </div>
    );
  }
});
