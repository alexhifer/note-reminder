Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  authenticate :admin_user do
    mount Sidekiq::Web => '/admin/sidekiq_monitor'
  end

  devise_for :users, skip: :all

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'sign_up', to: 'registrations#create'
        post 'sign_in', to: 'sessions#create'
        post 'notes',   to: 'notes#create'
      end
    end
  end

  root 'homepage#index'
end
