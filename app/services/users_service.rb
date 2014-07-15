# This service handles the User's lifecycle.
module UsersService
  module_function

  # Return a list of Hashes containing each User.
  def all_users
    User.all.map(&:attributes)
  end

  # Fetch a User by their session.
  def get_user(session)
    User.where(session: session).first.try(&:attributes)
  end

  # Given a session, test if that User exists.
  def exists?(session)
    User.exists?(session: session)
  end

  # Create a new User, returning its attributes. A unique session will be generated.
  def create_user
    User.create!(session: sessions.next).attributes
  end

  # Delete a User.
  def destroy_user(session)
    User.where(session: session).destroy_all
    nil
  end

  # This is an infinite enumerator of sessions.
  def sessions
    return enum_for(:sessions) unless block_given?
    loop do
      session = 32.times.map { rand(10) }.join
      yield session unless exists?(session)
    end
  end
  private_class_method :sessions
end
