Peephole::Engine.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :logfiles, only: [:show], id: /.+/ do
    member do
      get :download
      get :raw
    end
  end
end
