Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'products/:id => 'catalog#view'
  # ^ can be rewritten to make it clearer as to what ruby is doing
  # get({'products/:id' => 'catalog#view'})
  # ^ is a ruby method with 1 argument of a hash
  # Remember that a Rails route maps a URL to a Controller and Action
  get({'/hello_world' => 'posts#home'})
  #      ^ URL    Controller^     ^Action
  #      ^ URL         Class^     ^Method


  get '/posts' => 'posts#index'
  get '/posts/:id' => 'posts#show', as: :post

  get '/team' => 'static#team'
  get '/about' => 'static#about'




end
