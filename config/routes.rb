Rails.application.routes.draw do
  resources :books, only: %i[index new create]

  get '/', to: 'books#index'
end
