Booking::Application.routes.draw do
  resources :meetings
  resources :landlords
  resources :tenants
  root to: 'main#index'
end
