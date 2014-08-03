/** @jsx React.DOM */

var Views = Views || {};

Views.Search = React.createClass({
  getInitialState: function() {
    return { filter: '', filteredBars: [], selectedBars: [] };
  },

  bars: function() {
    return [
      {
        name: "Yard House",
      },
      {
        name: "Bar Loiue",
      },
    ];
  },

  addBar: function(bar) {
    var component = this;

    return function(e) {
      var selected = component.state.selectedBars,
          filtered = component.state.filteredBars;
      selected.unshift(bar);

      component.setState({
        filteredBars: filtered.filter(function(thisBar) {
          return thisBar !== bar;
        }),
        selectedBars: selected
      });
      e.preventDefault();
    };
  },

  removeBar: function(bar) {
    var component = this;

    return function(e) {
      if(bar.name.toLowerCase().search(component.state.filter) === -1) {
        component.setState({
          filteredBars: component.state.filteredBars,
          selectedBars: component.state.selectedBars.filter(function (thisBar) {
            return thisBar !== bar;
          })
        });
      } else {
        var filtered = component.state.filteredBars;
        filtered.unshift(bar);
        component.setState({
          filteredBars: filtered,
          selectedBars: component.state.selectedBars.filter(function (thisBar) {
            return thisBar !== bar;
          })
        });
      }

      e.preventDefault();
    };
  },

  handleSubmit: function(e) {
  },

  handleChange: function(e) {
    var value     = document.querySelector('#searchInput').value.toLowerCase(),
        component = this,
        filtered  = this.bars().filter(function(bar) {
          return (bar.name.toLowerCase().search(value) !== -1) &&
                 (component.state.selectedBars.indexOf(bar) === -1);
        });

    this.setState({ filter: value, filteredBars: filtered, selectedBars: this.state.selectedBars });
  },

  displaySelected: function(bar) {
    return (
      <li key={bar.name}>
        <p className="lead">
          <a href="#" onClick={this.removeBar(bar)}>{bar.name}</a>
        </p>
      </li>
    );
  },

  displayUnselected: function(bar) {
    return (
      <li key={bar.name}>
        <p className="lead">
          <a href="#" onClick={this.addBar(bar)}>{bar.name}</a>
        </p>
      </li>
    );
  },

  render: function() {
    return (
      <div className="container-fluid">
        <input type="text"
               id="searchInput"
               className="form-control"
               placeholder="Search for a bar"
               onChange={this.handleChange}
               />

        <div className="row">
          <div className="col-lg-6">
            <h2>Matched Bars</h2>
            <ul className="list-unstyled">
              {this.state.filteredBars.map(this.displayUnselected)}
            </ul>
          </div>

          <div className="col-lg-6">
            <h2>Selected Bars</h2>
            <ul className="list-unstyled">
              {this.state.selectedBars.map(this.displaySelected)}
            </ul>
          </div>
        </div>
      </div>
    );
  }
});
