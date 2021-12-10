Rails.application.routes.draw do
  resources :test_pdf, only: :index
end