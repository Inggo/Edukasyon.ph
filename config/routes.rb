Rails.application.routes.draw do
  # All resource controllers are ran under /api route
  scope(:path => '/api') do
    resources :courses
    resources :professors
    resources :ratings, :only => [:create]
  end

  # Landing controller displays the landing view
  get 'landing/index'
  root 'landing#index'
end
