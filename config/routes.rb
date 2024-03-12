Rails.application.routes.draw do

  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
 
  devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root to: 'homes#top'
  end

  scope module: :public do
    root to: 'homes#top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
