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
    resources :users, only: :show
    delete 'users/information', to: 'users#destroy'
    resources :categories, only: [:index, :create, :update, :destroy, :edit]
    resources :colors, only: [:index, :create, :update, :destroy, :edit]
    resources :items, only: [:show, :destroy]
    resources :shops, only: [:show, :index, :edit, :update, :destroy]
  end

  scope module: :public do
    root to: 'homes#top'
    get "search_tag" => "homes#search_tag"
    get 'home/about', to: 'homes#about', as: :about
    resources :users, only: :show
    get 'users/information/edit', to: 'users#edit', as: :edit
    patch 'users/information', to: 'users#update'
    delete 'users/information', to: 'users#destroy'
    resources :shops, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :items, only: [:new, :create, :show, :destroy, :update, :edit]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
