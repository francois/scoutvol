Rails.application.routes.draw do
  with_dev_auth = lambda do |app|
    if ENV["ADMIN_USERNAME"].present?
      Rack::Builder.new do
        use Rack::Auth::Basic do |username, password|
          # NOTE: Yes, we use & instead of &&. This is to protect against timing attacks. & needs to evaluate both arguments, while && will may only evaluate one.
          ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV.fetch("ADMIN_USERNAME"))) &
            ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV.fetch("ADMIN_PASSWORD")))
        end

        run app
      end
    else
      app
    end
  end

  mount Avo::Engine, at: Avo.configuration.root_path
  mount with_dev_auth[GoodJob::Engine], at: "/good_job"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  get "registrations/:season_slug", to: "registrations#index", as: :registrations
  get "registrations/:event_slug/new", to: "registrations#new", as: :new_registration
  post "registrations/:event_slug", to: "registrations#create", as: :create_registration
  get "metrics/:season_slug", to: "metrics#show", as: :metrics
  get "attendances/:event_slug", to: "attendances#index", as: :attendances
  post "attendances", to: "attendances#create", as: :create_attendance
end
