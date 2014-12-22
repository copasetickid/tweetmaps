Rails.application.routes.draw do

  devise_for :users, :path_names => { sign_in: 'login', sign_out: 'logout' },
    :controllers => {
     :omniauth_callbacks => "users/omniauth_callbacks",
    }

  root "home#index"
end
