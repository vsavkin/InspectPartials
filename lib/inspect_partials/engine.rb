module InspectPartials
  class InspectPartialsEngine < Rails::Engine
    initializer "inspect_partials_engine.add_rack_middleware" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/app/assets"
      app.middleware.use InspectPartials::RackHandler
    end

    initializer "inspect_partials_engine.patch_action_view_template" do
      next unless config.respond_to?(:inspect_partials)
      next unless config.inspect_partials

      class ActionView::Template
        alias :show_partials_railtie_old_source :source

        def source
          @show_partials_railtie_new_source ||= source_wrapped_into_tooltip
        end

        private
        def source_wrapped_into_tooltip
          source = show_partials_railtie_old_source
          return source if layout?
          %Q{<div class="inspect-partials-tooltip" data-tip="#{relative_identifier}">#{source}</div>}
        end

        def relative_identifier
          match = /app\/views.*/.match identifier
          match[0] ? match[0] : identifier
        end

        def layout?
          relative_identifier =~ /layouts\//
        end
      end
    end
  end
end