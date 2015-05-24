module MovieManager
  class Engine < ::Rails::Engine
    isolate_namespace MovieManager

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s + File::SEPARATOR
        config.paths["db/migrate"].expanded.each do |path|
          app.config.paths["db/migrate"] << path
        end
      end
    end
  end
end
