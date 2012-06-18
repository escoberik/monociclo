module Rails; def self.app_name; Rails.application.class.parent_name.downcase; end; end
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Monociclo::Application.initialize!
