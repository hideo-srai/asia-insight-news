Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, path: 'cms-auth', path_names: { sign_in: 'signin', sign_out: 'signout' }

  devise_for :users,
             path_names: { sign_in: 'signin', sign_up: 'singup', sign_out: 'signout' },
             controllers: { cas_sessions: 'cas_sessions' }
  get 'auth/twitter', as: :twitter_auth
  get 'auth/twitter/callback', to: 'twitter#create'
  delete 'auth/twitter/:id', to: 'twitter#destroy', as: :remove_twitter

  get 'sitemap' => 'site#sitemap', format: :xml

  get 'admin', to: redirect('/admin/dashboard')
  namespace :admin do
    get 'dashboard' => 'dashboard#index'

    get 'digest' => 'dashboard#digest', as: :digest

    resources :posts do
      get 'twitter-alerts', action: :new_twitter_alert
      put 'twitter-alerts', action: :alert_via_twitter
    end
    resources :blog_posts
    resources :authors
    resources :post_sections, path: 'sections'
    resources :events
    resources :central_banks, path: 'central-banks'
    resources :links
    resources :countries
    resources :pages, only: [:index, :edit, :update]
    resources :charts

    resources :sales_managers
    resources :users, only: [:index, :edit, :update] do
      get 'export', action: :export, on: :collection
    end
    resources :email_alerts, path: 'manual-email-alerts', only: [:new, :index, :show, :destroy] do
      get 'common-settings', action: 'common_settings'
      put 'common-settings', action: 'update_common_settings'

      get 'custom-texts', action: 'custom_texts'
      put 'custom-texts', action: 'update_custom_texts'
    end

    resources :email_alert_schedules, path: 'email-alerts-schedule', only: [:index, :new, :show, :create, :update, :destroy, :edit]
    resources :pdf_email_alerts, path: 'pdf-alerts', only: [:index, :new, :create] do
      member do
        get :preview
        put 'send', action: 'send_pdf'
      end
    end


    resources :site_settings, path: 'settings', only: [:index, :update]
  end

  resources :blog_posts, only: [:index, :show], path: 'blog'
  resources :posts, only: [:index, :show] do
    collection do
      get 'section/:section_slug', action: :index, as: :section
      get 'country/:country_slug', action: :index, as: :country
    end

    post 'mark-read', action: :mark_read, on: :member
  end

  resources :events, only: :index
  resources :links, only: :index

  resources :central_banks, only: :index, path: 'central-banks'
  resources :authors, only: [:show]
  resources :subscribers, only: [:create]
  resource  :user, only: [:create, :edit, :update] do
    collection do
      post :short_create
      post :invite_request
    end
  end

  get 'search' => 'search#index', as: :search

  get ':slug' => 'pages#show', as: :page

  root to: 'posts#index', is_home_page: true
end
