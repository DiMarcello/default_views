module DefaultViews
  PATH = "default"
  
  module ActionViewMethods
    def _pick_partial_template(partial_path) #:nodoc:
      if partial_path.include?('/')
        path = File.join(File.dirname(partial_path), "_#{File.basename(partial_path)}")
      elsif controller
        path = "#{controller.class.controller_path}/_#{partial_path}"
      else
        path = "_#{partial_path}"
      end

      default_name = "#{DefaultViews::PATH}/#{path.split('/').last}"
      path = default_name if !@controller.send(:template_exists?, path) && @controller.send(:template_exists?, default_name)
      _pick_template path
    end
  end
  
  module ActionControllerMethods
    def self.included(base)
      base.alias_method_chain :default_template_name, :default
    end
    
    private
    def default_template_name_with_default(action_name = self.action_name)
      template_name = default_template_name_without_default(action_name)
      default_name = "#{DefaultViews::PATH}/#{action_name}"
      if !template_exists?(template_name) && template_exists?(default_name)
        default_name
      else
        template_name
      end
    end
  end
end