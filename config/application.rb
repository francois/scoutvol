require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Scoutvol
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_record.schema_format = :sql

    config.active_record.default_timezone = :utc
    config.active_record.time_zone_aware_attributes = true

    config.active_job.queue_adapter = :good_job
    config.good_job.preserve_job_records = true
    config.good_job.retry_on_unhandled_error = true
    config.good_job.on_thread_error = ->(exception) { Rails.error.report(exception) }
    config.good_job.queues = "*:5"
    config.good_job.poll_interval = 31 # seconds
    config.good_job.shutdown_timeout = 25 # seconds
    config.good_job.enable_cron = true
    config.good_job.cron_graceful_restart_period = 5.minutes
    config.good_job.dashboard_default_locale = :en
    config.good_job.queue_select_limit = 1000
    config.good_job.execution_mode =
      case Rails.env
      when "development"
        :external
      when "test"
        :inline
      when "production"
        :external
      else
        raise ArgumentError, "Unknown Rails.environment: #{Rails.environment.inspect}"
      end

    config.good_job.cron = {
      send_event_reminder_job: {
        cron: "17 7 * * * America/Montreal", # daily, at 5:17 am
        class: "SendEventReminderJob"
      }
    }
  end
end
