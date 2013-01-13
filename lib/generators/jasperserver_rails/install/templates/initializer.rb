Rails.configuration.after_initialize do
  Rails.configuration.jasperserver = YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'jasperserver.yml'))).result).deep_symbolize_keys
end
