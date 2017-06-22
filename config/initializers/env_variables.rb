Rails.application.secrets.each do |key, value|
  ENV[key.to_s] = value.to_s
end
