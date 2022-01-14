# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
           scope: 'userinfo.email',
           prompt: 'consent'
  # ,
  # client_options: {
  #   ssl: {
  #     ca_file: Rails.root.join('cacert.pem').to_s
  #   }
  # }
end
