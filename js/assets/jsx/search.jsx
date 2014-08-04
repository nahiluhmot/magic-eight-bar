/** @jsx React.DOM */

var Views = Views || {};

Views.Search = React.createClass({
  getInitialState: function() {
    return { filter: '', filteredBars: [], selectedBars: [], helpText: '' };
  },

  bars: function() {
    return [
      {
        name: 'Yard House',
        placeId: '1'
      },
      {
        name: 'Bar Louie',
        placeId: '2'
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
      this.setState({ helpText: 'Please select at least one bar.' });
    } else {
      Aviator.navigate('/results', { queryParams: { places: places } });
    }
  },

  handleClick: function(e) {
    document.querySelector('#post-search').style.paddingBottom = '1000px';
    smoothScroll.animateScroll(null, '#search-container', {
      speed: 400,
      updateURL: false,
      offset: 70,
      easing: 'easeInCubic'
    });
    this.setState({
      helpText: 'Enter some bars you like, add them to your list, and click ' +
                '"Let\'s Go!"'
    });
  },

  handleChange: function(e) {
    var value     = document.querySelector('#searchInput').value.toLowerCase(),
        component = this,
        filtered  = this.bars().filter(function(bar) {
          return (value.length > 0) &&
                 (bar.name.toLowerCase().search(value) !== -1) &&
                 !component.isSelected(bar);
        });

    this.setState({ filter: value, filteredBars: filtered });
  },

  displaySelected: function(bar) {
    return (
      <li key={bar.name}>
        <p className='lead'>
          <a href='#' onClick={this.removeBar(bar)}>
            <i className='glyphicon glyphicon-minus' />&nbsp;{bar.name}
          </a>
        </p>
      </li>
    );
  },

  displayUnselected: function(bar) {
    return (
      <li key={bar.name}>
        <p className="lead">
          <a href="#" onClick={this.addBar(bar)}>
            <i className="glyphicon glyphicon-plus"></i>&nbsp;{bar.name}
          </a>
        </p>
      </li>
    );
  },

  displayAllUnselected: function() {
    if(this.state.filteredBars.length > 0) {
      return (
        <div>
          <h2>Search results:</h2>
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
          <h2>Your list:</h2>
          <ul className="list-unstyled">
            {this.state.selectedBars.map(this.displaySelected)}
          </ul>
        </div>
      );
    }
  },

  render: function() {
    return (
      <div className="container-fluid top-level">
        <div id="search-container" className="row">
          <div className="col-sm-10">
            <input type="text"
                   id="searchInput"
                   className="form-control input-lg"
                   placeholder="Search for a bar"
                   onClick={this.handleClick}
                   onChange={this.handleChange}
                   />
           </div>
          <div className="col-sm-2">
            <button className="btn btn-lg btn-primary"
                    onClick={this.handleSubmit}>
              Let's go!
            </button>
          </div>
        </div>

        <br />
        <br />

        <div className="row">
          <p className="lead text-center">{this.state.helpText}</p>
        </div>

        <div id="post-search" className="row">
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
