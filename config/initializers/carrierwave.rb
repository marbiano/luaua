CarrierWave.configure do |config|
  unless %w[development test].include? Rails.env
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => '',
      :aws_secret_access_key  => '',
      :region                 => 'us-east-1'
    }

    config.fog_directory  = "luaua"
    #config.fog_host       = 'https://assets.example.com'
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}

    # Heroku workaround
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end
end
