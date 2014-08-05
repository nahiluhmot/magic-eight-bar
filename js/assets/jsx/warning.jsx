/** @jsx React.DOM */

var Views = Views || {};

Views.Warning = React.createClass({
  cookieIsSet: function() {
    var sessionId = Utils.getCookies()['id'];

    return (typeof sessionId === 'string') &&
           (sessionId.length > 0);
  },

  createUser: function() {
    reqwest({
      url: '/api/users/',
      method: 'POST',
      type: 'json',
      error: function() { goToGoogle(); },
      success: function() { $('#warningModal').modal('hide'); }
    });
  },

  goToGoogle: function() {
    window.location.href = 'http://google.com';
  },

  componentDidMount: function() {
    if(!this.cookieIsSet()) {
      $('#warningModal').modal('show');
    }
  },

  render: function() {
    return (
      <div id="warningModal" className="modal fade">
        <div className="modal-dialog">
          <div className="modal-content">

            <div className="modal-header">
              <button type="button" className="close" data-dismiss="modal">
                <span aria-hidden="true">&times;</span>
                <span className="sr-only">Close</span>
              </button>
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
