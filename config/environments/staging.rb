require_relative 'production'

Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'asia-insight.mni.demostage.me' }
  config.new_subscribers_email = 'ana@pixel-nyc.com'
end
