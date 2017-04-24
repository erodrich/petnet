Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :pets do
        resources :posts
    end
    get  'search', to: 'posts#search'
    post 'auth/login', to: 'authentication#authenticate'
    post 'signup', to: 'users#create'
end
