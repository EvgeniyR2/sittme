# frozen_string_literal: true

class BookSerializer < Representable::Decorator
  include Representable::JSON

  property :title
  property :author
  property :genre
end
