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
        site: "http://www.yardhouse.com",
        placeId: "1"
      },
      {
        name: "Bar Loiue",
        site: "http://www.barlouieamerica.com/",
        placeId: "2"
      },
    ];
  },

  isSelected: function(bar) {
    var foundBars = this.state.selectedBars.filter(function(current) {
      return current.name === bar.name;
    });

    return foundBars.length > 0;
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
      var filtered = component.state.filteredBars;

      if(bar.name.toLowerCase().search(component.state.filter) !== -1) {
        filtered.unshift(bar);
      }

      component.setState({
        filteredBars: filtered,
        selectedBars: component.state.selectedBars.filter(function(thisBar) {
          return thisBar.name !== bar.name;
        })
      });

      e.preventDefault();
    };
  },

  handleSubmit: function(e) {
    var places = this.state.selectedBars.map(function(bar) {
      return bar.placeId;
    });
    e.preventDefault();

    if(places.length === 0) {
    } else {
      Aviator.navigate("/results", { queryParams: { places: places } });
    }
  },

  handleChange: function(e) {
    var value     = document.querySelector('#searchInput').value.toLowerCase(),
        component = this,
        filtered  = this.bars().filter(function(bar) {
          return (value.length > 0) &&
                 (bar.name.toLowerCase().search(value) !== -1) &&
                 !component.isSelected(bar);
        });

    this.setState({ filter: value, filteredBars: filtered, selectedBars: this.state.selectedBars });
  },

  displaySelected: function(bar) {
    return (
      <li key={bar.name}>
        <p className="lead">
          <a href="#" onClick={this.removeBar(bar)}><i className="glyphicon glyphicon-minus"></i></a>
          &nbsp;
          <a target="_blank" href={bar.site}>{bar.name}</a>
        </p>
      </li>
    );
  },

  displayUnselected: function(bar) {
    return (
      <li key={bar.name}>
        <p className="lead">
          <a href="#" onClick={this.addBar(bar)}><i className="glyphicon glyphicon-plus"></i></a>
          &nbsp;
          <a target="_blank" href={bar.site}>{bar.name}</a>
        </p>
      </li>
    );
  },

  displayAllUnselected: function() {
    if(this.state.filteredBars.length > 0) {
      return (
        <div>
          <h2>Matched Bars:</h2>
          <ul className="list-unstyled">
            {this.state.filteredBars.map(this.displayUnselected)}
          </ul>
        </div>
      );
    }
  },

  displayAllSelected: function() {
    if(this.state.selectedBars.length > 0) {
      return (
        <div>
          <h2>Selected Bars:</h2>
          <ul className="list-unstyled">
            {this.state.selectedBars.map(this.displaySelected)}
          </ul>
        </div>
      );
    }
  },

  render: function() {
    return (
      <div className="container-fluid">
        <div className="row">
          <div className="col-sm-10">
            <input type="text"
                   id="searchInput"
                   className="form-control input-lg"
                   placeholder="Search for a bar"
                   onChange={this.handleChange}
                   />
           </div>
          <div className="col-sm-2">
            <button className="btn btn-primary" onClick={this.handleSubmit}>Let's go!</button>
          </div>
        </div>

        <div className="row">
          <div className="col-lg-6">
            {this.displayAllUnselected()}
          </div>

          <div className="col-lg-6 text-right">
            {this.displayAllSelected()}
          </div>
        </div>
      </div>
    );
  }
});
