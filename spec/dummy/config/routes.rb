Rails.application.routes.draw do
  root 'welcome#index'

  mount Peephole::Engine => "/peephole"
end
