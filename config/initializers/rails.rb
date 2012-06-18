module Rails
  def self.app_name
    Rails.application.class.parent_name.downcase
  end
end
