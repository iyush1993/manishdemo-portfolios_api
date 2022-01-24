scope module: :v1 do
  # resources :users
  post "v1/users/signup", to: "users#sign_up"
  post "v1/auth/signin", to: "users#sign_in"

  # get 'projects/create'
  get 'v1/projects', to: "projects#index"
  post 'v1/projects', to: "projects#create"
  get 'v1/projects/:id', to: "projects#show"

  # get 'projects/update'
  # get 'projects/delete'

end
