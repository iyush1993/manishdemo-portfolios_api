namespace :api, compress: false do
  draw :v1, :api
  # [:v1].map { |api| draw api, :api }
end
