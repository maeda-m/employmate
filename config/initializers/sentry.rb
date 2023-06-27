sentry_ingest_url = ENV['SENTRY_INGEST_URL'].presence
if sentry_ingest_url
  Sentry.init do |config|
    config.dsn = sentry_ingest_url
    config.breadcrumbs_logger = %i[active_support_logger http_logger]

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    config.traces_sample_rate = 1.0
    # or
    config.traces_sampler = lambda do |_context|
      true
    end
  end
end
