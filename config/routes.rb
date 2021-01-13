Rails.application.routes.draw do
  resources :dinosaurs
  resources :cages do 
    member do
      patch :toggle_power
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
