Rails.application.routes.draw do
  get 'home/index'

  resources :locations
  resources :instructors
  resources :curriculums
  resources :camp_instructors
  resources :camps
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'about', :to => 'home#about'
  get 'contact', :to => 'home#contact'
  get 'privacy', :to => 'home#privacy'

  root to: 'home#index' , as: :home
end
