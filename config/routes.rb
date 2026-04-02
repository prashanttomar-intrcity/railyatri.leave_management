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
  end
end