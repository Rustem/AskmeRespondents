AskmeModel::Application.routes.draw do
  root :to => 'respondents#index'

  devise_for :respondents, :controllers => { :sessions => "respondents/sessions", :registrations => "respondents/registrations", :omniauth_callbacks => "respondents/omniauth_callbacks" }
  devise_for :responds, :controller => "fake_questions"

  # profile 
  match 'profile' => 'respondents#show'
  match 'profile/edit/' => 'respondents#edit#:id', :as => "pr_edit"

  resources :respondents do
    resources :profiles do
      member do
        post 'social_demographic_settings', :as => :sd
        post 'business_settings', :as => :business
      end          
    end
  end

  #survey construction
  match 'surveys/:id/edit/page/:pagenumber' => 'surveys#edit#:id', :as => "survey_edit_page"

  #this is just for testing, need to be delete'
  match 'submitAnswers' => 'fakeQuestions#submitAnswers', :as => 'sa'

  resources :surveys do
    resources :pages do
      resources :questions do 
        
      end
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

 
  # match '/signin' => 
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
