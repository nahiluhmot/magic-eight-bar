# This module changes #attributes so that a Mash is returned instead.
module MashAttributes
  extend ActiveSupport::Concern

  def attributes
    Hashie::Mash.new(super).tap do |mash|
      %w(created_at updated_at).each { |key| mash.delete(key) }
    end
  end
end
