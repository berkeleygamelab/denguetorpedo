if Rails.env == 'production'
  S3_CREDENTIALS = { access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['SECRET_ACCESS_KEY'], bucket: ENV['S3_BUCKET_NAME'] }
  STORAGE = :s3
else
  S3_CREDENTIALS = nil
  STORAGE = :filesystem
end
