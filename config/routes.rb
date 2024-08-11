Rails.application.routes.draw do
  concern :activatable do
    member do
      put :activate
      put :deactivate
    end
  end

  namespace :main, path: "", path_names: { new: "novo", create: "novo", edit: "editar", update: "editar" } do
    root "dashboards#index"

    resources :sales, path: "vendas", except: [ :edit, :update ]

    with_options concerns: [ :activatable ], except: [ :destroy ] do
      resources :products, path: "produtos"
      resources :customers, path: "clientes"
    end

    resources :reports, path: "relatorios" do
      collection do
        get :month_report, format: "pdf"
        get :period_report, format: "pdf"
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
