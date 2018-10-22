# Paperclip defaults for AWS S3
# (env vars are defined in config/application.yml and loaded into env by figaro)
if Rails.env.production? || Rails.env.development?
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:s3_credentials] = {
    bucket: ENV["S3_BUCKET"],
    access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
  }
  Paperclip::Attachment.default_options[:s3_region] = ENV["AWS_REGION"]
elsif Rails.env.test?
  # these are obviously fake! but values are needed to init properly
  # we will just be mocking things anyway
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:s3_credentials] = {
    bucket: "test",
    access_key_id: "test",
    secret_access_key: "test"
  }
  Paperclip::Attachment.default_options[:s3_region] = "test"
end
