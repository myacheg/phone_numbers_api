Rails.application.routes.draw do
  resources :numbers, constraints: { format: :json }, only: [:new]
end
