Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'monitoring' do
    get '/health' => 'health#index'
  end

  namespace 'v1' do
    post '/rent-a-car' => 'rentals#rent'
    post '/return-a-car' => 'rentals#return'
    post '/pay-a-car' => 'rentals#pay'
    post '/cashback' => 'rentals#cashback'
  end
end
