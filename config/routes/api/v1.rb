scope module: :v1 do
  # resources :users
  post "v1/users/signup", to: "users#sign_up"
  post "v1/auth/signin", to: "users#sign_in"
end
