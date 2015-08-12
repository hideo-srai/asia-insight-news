Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, path: 'cms-auth', path_names: { sign_in: 'signin', sign_out: 'signout' }

  devise_for :users,
             path_names: { sign_in: 'signin', sign_up: 'singup', sign_out: 'signout' },
             controllers: { cas_sessions: 'cas_sessions' }

  root to: 'posts#index', is_home_page: true
  get 'sitemap' => 'site#sitemap', format: :xml

  get 'admin', to: redirect('/admin/dashboard')
  namespace :admin do
    get 'dashboard' => 'dashboard#index'

    get 'digest' => 'dashboard#digest', as: :digest

    resources :posts
    resources :blog_posts
    resources :authors
    resources :post_sections, path: 'sections'
    resources :events
    resources :central_banks, path: 'central-banks'
    resources :links
    resources :countries
    resources :pages, only: [:index, :edit, :update]
    resource :chart, only: [:show, :update]

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

  get 'search' => 'search#index', as: :search

  get ':slug' => 'pages#show', as: :page
end