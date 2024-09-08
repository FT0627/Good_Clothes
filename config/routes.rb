Rails.application.routes.draw do

  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:show, :destroy] do
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
  end
    resources :categories, only: [:index, :create, :update, :destroy, :edit]
    resources :colors, only: [:index, :create, :update, :destroy, :edit]
    resources :items, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :shops, only: [:show, :index, :edit, :update, :destroy]
  end

  scope module: :public do
    root to: 'homes#top'
    get "search_tag" => "homes#search_tag"
    get 'home/about', to: 'homes#about', as: :about

    resources :users, only: [:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"

      member do
        get :favorites
      end
    end
    resources :shops, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
    end
    resources :items, only: [:new, :create, :show, :destroy, :update, :edit] do
      resources :post_comments, only: [:create, :destroy]
    end
    get "items" => "items#new"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
