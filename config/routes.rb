# frozen_string_literal: true

Rails.application.routes.draw do
  concern :activable do
    member do
      put :activate
      put :deactivate
    end
  end

  namespace :main, path: "", path_names: { new: "novo", create: "novo", edit: "editar", update: "editar" } do
    root "dashboards#index"

    resources :sales, path: "vendas", except: %i[edit update]

    with_options concerns: [ :activable ], except: [ :destroy ] do
      resources :products, path: "produtos"
      resources :customers, path: "clientes"
    end

    resources :closing_periods, path: "fechamentos", except: %i[edit update destroy]

    resources :reports, path: "relatorios" do
      collection do
        get :month_report, format: "pdf"
        get :period_report, format: "pdf"
      end
    end
  end
end
