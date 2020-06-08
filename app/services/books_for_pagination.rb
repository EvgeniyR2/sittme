# frozen_string_literal: true

class BooksForPagination
  def call(command, cursor, quantity = 10)
    case command
    when 'prev_page' then books_prev_page(cursor, quantity)
    when 'next_page' then books_next_page(cursor, quantity)
    else Book.order(:created_at).first(quantity)
    end
  end

  private

  def books_prev_page(cursor, quantity)
    books = Book.where('id < :value', value: cursor.to_i).order(:created_at).last(quantity)
    books = Book.order(:created_at).first(quantity) if books.empty?
    books
  end

  def books_next_page(cursor, quantity)
    books = Book.where('id > :value', value: cursor.to_i).order(:created_at).first(quantity)
    books = Book.order(:created_at).last(quantity) if books.empty?
    books
  end
end
