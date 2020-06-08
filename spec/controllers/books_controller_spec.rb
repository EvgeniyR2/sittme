# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController do
  render_views

  describe 'GET index' do
    let!(:book) { FactoryBot.create(:book) }

    it 'html response' do
      get :index
      expect(response.status).to eq(200)
    end

     it 'json response' do
      get :index, format: :json
      books = Book.first(10)
      books_serialized = BookSerializer.for_collection.new(books).to_json
      expect(response.status).to eq(200)
      expect(response.body).to eq(books_serialized)
    end
  end

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    it 'creates book' do
      post :create, params: { book: { title: 'title', author: 'author', genre: 'genre' } }
      expect(response).to redirect_to(books_path)
    end
  end
end
