module Peephole
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def install
      template 'log_tags.rb', 'config/initializers/log_tags.rb'
      template 'initializer.rb', 'config/initializers/peephole.rb'
    end
  end
end
