Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "1661854867448474", "1c466099fbf5b9a23147e086d81eae1c", { :scope => 'user_location, user_birthday, user_about_me, email'}
end
