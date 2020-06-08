# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksForPagination do
  before do
    FactoryBot.create_list(:book, 15)
  end

  let(:quantity) { 10 }

  describe '#call' do
    context 'with command nil' do
      let(:command) { nil }

      it 'get 10 first books' do
        books = BooksForPagination.new.call(command, nil)
        expect(books).to eq(Book.order(:created_at).first(quantity))
      end
    end

    context 'with command prev_page' do
      let(:command) { 'prev_page' }

      it 'get 10 books before 12th ' do
        cursor = Book.first.id + 11
        books = BooksForPagination.new.call(command, cursor, quantity)
        expect(books).to eq(Book.where("id < :value", value: cursor.to_i).order(:created_at).last(quantity))
      end

      it 'get 10 first books if cursor nil' do
        cursor = nil
        books = BooksForPagination.new.call(command, cursor)
        expect(books).to eq(Book.order(:created_at).first(quantity))
      end
    end

    context 'with command next_page' do
      let(:command) { 'next_page' }

      it 'get 10 books after 1th ' do
        cursor = Book.order(:created_at).first.id
        books = BooksForPagination.new.call(command, cursor, quantity)
        expect(books).to eq(Book.where("id > :value", value: cursor.to_i).order(:created_at).first(quantity))
      end

      it 'get 10 last books if cursor too big' do
        cursor = Book.order(:created_at).last.id + 1
        books = BooksForPagination.new.call(command, cursor)
        expect(books).to eq(Book.order(:created_at).last(quantity))
      end
    end
  end
end
