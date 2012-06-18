settings =
  YAML.load_file("#{Rails.root}/config/paperclip.yml")[Rails.env].symbolize_keys.inject({}) do |hash, option|
    hash.merge!({ option[0] => eval('"'+option[1]+'"') })
  end.merge default_style: :thumb

Paperclip::Attachment.default_options.merge!(settings)
