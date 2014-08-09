/** @jsx React.DOM */

var Views = Views || {};

Views.About = React.createClass({
  render: function() {
    return (
      <div className="container top-level fix-margin">
        <h1>About</h1>

        <p>
          In the summer session of 2014, five classmates were presented to create a project to showcase their skills in software engineering.
          After a couple of days of deliberation, a decision was made: Magic 8 Bar.
          From there, James, Tim, Tom, Chris, and Shawn set out to make a web based application that would assist you in finding bars that you like.
        </p>

        <p>
          The idea for Magic 8 Bar came from the daunting amount of bars located in and around Boston.
          It would be hard (but not entirely impossible) to try every bar to see which ones you prefer.
          Instead, let Magic 8 Bar do the work for you.
          It will get you to expand your bar knowledge by suggesting relevant bars that are similar to bars you already like.
        </p>

        <p>
          Currently, Magic 8 Bar is localized to only Boston, but has plans to expand to other major cities to help people discover places they will like.
        </p>
      </div>
    );
  }
});
