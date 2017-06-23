Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/', graphql_path: '/graphql'
  end

  post '/graphql', to: 'graphql#execute'
end
