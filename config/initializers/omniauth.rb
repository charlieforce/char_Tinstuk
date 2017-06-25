Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET'],
           scope: 'user_location,user_birthday,user_about_me,email'
end
