/** @jsx React.DOM */

var Views = Views || {};

/**
 * This component is for rendering the "Are you 21+" warning on the home page.
 * It knows not to render that warning if the user has a valid cookie.
 */
Views.Warning = React.createClass({
  /**
   * Test if the cookie is set.
   */
  cookieIsSet: function() {
    var sessionId = Utils.getCookies()['id'];

    return (typeof sessionId === 'string') &&
           (sessionId.length > 0);
  },

  /**
   * Create a new user, hiding the modal on completion.
   */
  createUser: function() {
    var component = this;
    Users.create({
      error: function() { $('#warningModal').modal('hide');  },
      success: function() { $('#warningModal').modal('hide'); }
    });
  },

  /**
   * Redirect to Google.
   */
  goToGoogle: function() {
    window.location.href = 'http://google.com';
  },

  /**
   * After the component mounts, test if there is a valid logged in user. If
   * there is, the modal will remain invisible. Otherwise, it will show on the
   * page.
   */
  componentDidMount: function() {
    if(this.cookieIsSet()) {
      Users.valid({
        error: function() { $('#warningModal').modal('show') }
      });
    } else {
      $('#warningModal').modal('show');
    }
  },

  /**
   * Render the modal.
   */
  render: function() {
    return (
      <div id="warningModal" className="modal fade">
        <div className="modal-dialog">
          <div className="modal-content">

            <div className="modal-header">
              <h4 className="modal-title">Magic 8 Bar</h4>
            </div>

            <div className="modal-body text-center">
              <h3>Are you 21 or older?</h3>
            </div>

            <div className="modal-footer">
              <button type="button"
                      className="btn btn-primary"
                      onClick={this.createUser}>
                Yes
              </button>

              <button type="button"
                      className="btn btn-default"
                      onClick={this.goToGoogle}>
                No
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }
});
