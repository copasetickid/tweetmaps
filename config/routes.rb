Rails.application.routes.draw do

  devise_for :users, :path_names => { sign_in: 'login', sign_out: 'logout' },
    :controllers => {
     :omniauth_callbacks => "users/omniauth_callbacks",
    }

  root "pages#homepage"

  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ], as: :error_404
  match '/users/:id/finish-signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  get "/:id" => "pages#dashboard", as: :dashboard
  get "/followers/list" => "followers#fetch_followers", as: :follower_lookup
end
