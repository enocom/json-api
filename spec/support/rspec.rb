RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
