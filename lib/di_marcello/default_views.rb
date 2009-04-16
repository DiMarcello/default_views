module DiMarcello
  module DefaultViews
    PATH = "default"
    
    module ActionViewMethods
      
      def self.included(base)
        base.alias_method_chain :_pick_partial_template, :default
      end
      
      def _pick_partial_template_with_default(partial_path) #:nodoc:
        begin
          _pick_partial_template_without_default partial_path
        rescue ActionView::MissingTemplate => e
          begin
            _pick_partial_template_without_default "#{DiMarcello::DefaultViews::PATH}/#{partial_path.split('/').last}" 
          rescue ActionView::MissingTemplate
            raise e
          end
        end
      end
    end
    
    module ActionControllerMethods
      
      def self.included(base)
        base.alias_method_chain :default_template_name, :default
      end
      
      private
      unless ActionController::Base.private_instance_methods.include? 'template_exists?'
        def template_exists?(path)
          view_paths.find_template(path, response.template.template_format)
        rescue ActionView::MissingTemplate
          false
        end
      end
      
      def default_template_name_with_default(action_name = self.action_name)
        template_name = default_template_name_without_default(action_name)
        default_name = "#{DiMarcello::DefaultViews::PATH}/#{action_name}"
        if !template_exists?(template_name) && template_exists?(default_name)
          default_name
        else
          template_name
        end
      end
    end
  end
end