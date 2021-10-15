Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get 'basics', to: 'basics#index'
  get 'admin/users'
  get 'basics/news', to: 'basics#news'
  get 'basics/divide_by_zero', to: 'basics#divide_by_zero'
  get 'basics/divide', to: 'basics#divide'
  get 'basics/quotations', to: 'basics#quotations'
  post 'basics/quotations', to: 'basics#quotations'
  get 'basics/sql_tasks', to: 'basics#sql_tasks'
  get 'plan/index'
  get 'plan/profiles'
  get 'plan/user_management'
  root 'site#index'
end
