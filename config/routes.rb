Rails.application.routes.draw do
  resources :candidates do
    member do 
      post :vote
    end
  end

  #/candidates/:id/abc
  #/candidates/vote_list     collection

  # post "/candidates/:id/vote", to: "candidates#vote"
end