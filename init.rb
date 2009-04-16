# Include hook code here

require 'di_marcello/default_views'

ActionController::Base.send :include, DiMarcello::DefaultViews::ActionControllerMethods
ActionView::Base.send :include, DiMarcello::DefaultViews::ActionViewMethods