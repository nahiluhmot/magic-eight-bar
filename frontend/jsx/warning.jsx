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
    Users.create({ success: this.hideModal });
  },

  /**
   * Hide the modal this forces an Aviator reload.
   */
  hideModal: function() {
    $(this.getDOMNode()).modal('hide');
    $(this.getDOMNode()).hide();
    window.location.reload();
  },

  /**
   * Redirect to Google.
   */
  goToGoogle: function() {
    window.location.href = 'http://google.com';
  },

  showModal: function() {
    $(this.getDOMNode()).modal({ backdrop: 'static', keyboard: false });
  },

  /**
   * After the component mounts, test if there is a valid logged in user. If
   * there is, the modal will remain invisible. Otherwise, it will show on the
   * page.
   */
  componentDidMount: function() {
    if(this.cookieIsSet()) {
      Users.valid({ error: this.showModal });
    } else {
      this.showModal();
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
