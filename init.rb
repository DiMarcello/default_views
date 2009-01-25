# Include hook code here

require 'default_views'

ActionController::Base.send :include, DefaultViews::ActionControllerMethods
ActionView::Base.send :include, DefaultViews::ActionViewMethods