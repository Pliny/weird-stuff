WeirdStuff::Application.routes.draw do

  root to: 'weird_stuff#index'

  match '/skip', to: 'weird_stuff#skip'
end
