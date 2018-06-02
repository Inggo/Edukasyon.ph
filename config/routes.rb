Rails.application.routes.draw do
  scope(:path => '/api') do
    resources :courses
    resources :professors
    resources :ratings, :only => [:create]
  end
  get 'landing/index'
  root 'landing#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
