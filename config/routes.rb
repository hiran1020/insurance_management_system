Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  devise_for :users, controllers: { sessions: 'users/sessions' }

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  
  devise_scope :user do
    authenticated :user do
      root to: 'devise/sessions#new', as: :authenticated_root
    end
  
    unauthenticated do
      root to: 'application#index', as: :unauthenticated_root
    end
  end
end
 