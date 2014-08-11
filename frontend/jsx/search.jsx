/** @jsx React.DOM */

var Views = Views || {};

/**
 * This component handles the search functionality for the application.
 */
Views.Search = React.createClass({
  /**
   * Initially, there are no bars, we assume nothing has went wrong, and there
   * is no search.
   */
  getInitialState: function() {
    return {
      filter: '',
      filteredBars: [],
      selectedBars: [],
      helpText: '',
      bars: []
    };
  },

  /**
   * When the component is about to mount, asynchronously get the list of bars
   * from the backend.
   */
  componentWillMount: function() {
    var component = this;

    Bars.list({
      error: function() {
        component.setState({
          helpText: "Error communicating with server, please try again later"
        });
      },
      success: function(resp) {
        component.setState({ bars: resp });
      }
    });
  },

  /**
   * Test if th egiven bar has been selected by the user.
   */
  isSelected: function(bar) {
    var foundBars = this.state.selectedBars.filter(function(current) {
      return current.name === bar.name;
    });

    return foundBars.length > 0;
  },

  /**
   * Add a bar to the selected list.
   */
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

  /**
   * Remove a bar from the selected list.
   */
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

    /**
     * When the "Let's Go" button in clicked, route to the results page unless
     * the user has not selected any bars.
     */
  handleSubmit: function(e) {
    e.preventDefault();

    if(this.state.selectedBars.length === 0) {
      this.setState({ helpText: 'Please select at least one bar.' });
    } else {
      this.state.selectedBars.forEach(function(bar) {
        Reviews.create({
          bar: bar,
          rating: 1,
          success: function() {},
          error: function() {}
        });
      });
      Aviator.navigate('/results');
    }
  },

  /**
   * When the user clicks on the search bar, scroll down so that it is at the
   * top.
   */
  handleClick: function(e) {
    var newMargin = (window.innerHeight - 250) + 'px';
    document.querySelector('#post-search').style.marginBottom = newMargin;
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

  /**
   * Update the search results when the user types in the search field.
   */
  handleChange: function(e) {
    var value     = document.querySelector('#searchInput').value.toLowerCase(),
        component = this,
        filtered  = this.state.bars.filter(function(bar) {
          return (value.length > 0) &&
                 (bar.name.toLowerCase().search(value) !== -1) &&
                 !component.isSelected(bar);
        });

    this.setState({ filter: value, filteredBars: filtered });
  },

  /**
   * Display a selected bar.
   */
  displaySelected: function(bar) {
    return (
      <li key={bar.name}>
        <p className='lead'>
          <a href='#' onClick={this.removeBar(bar)}>
            - {bar.name}
          </a>
        </p>
      </li>
    );
  },

  /**
   * Display an unselected bar.
   */
  displayUnselected: function(bar) {
    return (
      <li key={bar.name}>
        <p className="lead">
          <a href="#" onClick={this.addBar(bar)}>
            + {bar.name}
          </a>
        </p>
      </li>
    );
  },
  /**
   * Display the selected bars.
   */
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


  /**
   * Display the search results.
   */
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

  /**
   * Render the search component.
   */
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
