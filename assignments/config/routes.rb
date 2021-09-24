Rails.application.routes.draw do
  resources :quotations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get 'basics', to: 'basics#index'
  get 'basics/news', to: 'basics#news'
  get 'basics/divide_by_zero', to: 'basics#divide_by_zero'
  get 'basics/divide', to: 'basics#divide'
  #get 'basics/quotations', to: 'basics#quotations'
  root 'site#index'
end
