# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'title' }
    author { 'author' }
    genre { 'genre' }
  end
end
