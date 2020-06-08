# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = BooksForPagination.new.call(params[:command], params[:cursor])
    respond_to do |format|
      format.html
      format.json { render json: BookSerializer.for_collection.new(@books).to_json }
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre)
  end
end
