Rails.application.routes.draw do
  resources :dinosaurs do
    member do
      patch :put_in_cage
    end
  end
  resources :cages do 
    member do
      patch :toggle_power
      get :show_dinosaurs
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
