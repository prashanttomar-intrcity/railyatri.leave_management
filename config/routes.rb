Rails.application.routes.draw do
  # Health check (keep this)
  get "up" => "rails/health#show", as: :rails_health_check

  # ==============================
  # API ROUTES (IMPORTANT)
  # ==============================
  namespace :api do
    post "signup", to: "auth#signup"
    post "login", to: "auth#login"

    resources :leave_requests

    get "manager/leaves", to: "leave_requests#all_leaves"

    get "users", to: "users#index"
  end
end