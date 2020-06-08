# frozen_string_literal: true

class BooksForPagination
  def self.call(command, cursor, quantity = 10)
    case command
    when 'prev_page'
      books = Book.where('id < :value', value: cursor.to_i).last(quantity)
      books = Book.first(quantity) if books.empty?
    when 'next_page'
      books = Book.where('id > :value', value: cursor.to_i).first(quantity)
      books = Book.last(quantity) if books.empty?
    else books = Book.first(quantity)
    end
    books
  end
end
