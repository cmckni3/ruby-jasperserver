module JasperserverRails
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)
      def copy_initializer
        copy_file 'initializer.rb', 'config/initializers/jasperserver.rb'
        copy_file 'jasperserver.yml', 'config/jasperserver.yml'
      end
    end
  end
end