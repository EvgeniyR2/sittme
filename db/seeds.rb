# frozen_string_literal: true

require 'faker'

100.times do
  Book.create(title: Faker::Book.title,
              author: Faker::Book.author,
              genre: Faker::Book.genre)
end
