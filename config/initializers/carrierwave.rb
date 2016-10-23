# CarrierWave.configure do |config|    config.fog_credentials = {
#     :provider               => 'AWS',       # required
#     :aws_access_key_id      => ENV['S3_ACCESS'],       # required
#     :aws_secret_access_key  => ENV['S3_SECRET']  ,    # required
#     :region                 => 'eu-west-1',
#     :endpoint => 'https://s3-eu-west-1.amazonaws.com',
#     :host               => 's3-eu-west-1.amazonaws.com'
#   }
#   config.fog_directory  = "villistadi-#{Rails.env}"
#
#
#   # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
# end

CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = "villistadi-#{Rails.env}"
  config.aws_acl    = :public_read

  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    access_key_id:     ENV.fetch('S3_ACCESS'),
    secret_access_key: ENV.fetch('S3_SECRET'),
    region: 'eu-west-1'
  }
end