Booking::Application.routes.draw do
  resources :meetings
  root to: 'main#index'
end
