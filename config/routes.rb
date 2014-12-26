Rails.application.routes.draw do

  devise_for :users, :path_names => { sign_in: 'login', sign_out: 'logout' },
    :controllers => {
     :omniauth_callbacks => "users/omniauth_callbacks",
    }

  root "pages#homepage"

  get "/:id" => "pages#dashboard", as: :dashboard
  get "/followerlookup" => "followers#fetch_followers", as: :follower_lookup
end
