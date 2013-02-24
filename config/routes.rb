WeirdStuff::Application.routes.draw do

  root to: 'weird_stuff#index'

  match '/skip', to: 'weird_stuff#skip'
  match '/reset', to: 'weird_stuff#reset'
  match '/next', to: 'weird_stuff#next'
end
