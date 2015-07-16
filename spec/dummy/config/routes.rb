Rails.application.routes.draw do
  mount Peephole::Engine => "/peephole"
  root 'welcome#index'
end
