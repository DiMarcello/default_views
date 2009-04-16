require 'test_helper'

class DefaultViewsTest < ActionController::TestCase
  class NotUsedController < ActionController::Base
    layout false
    prepend_view_path Rails.root.join('vendor', 'plugins', 'default_views', 'test', 'views').to_s
    
    def show1; end
    
    def show2; end
    
    def show3; end
    
    def show4; end
  end
  
  ActionController::Routing::Routes.draw do |map|
    map.connect 'show1', :controller => 'default_views_test/not_used', :action => 'show1'
    map.connect 'show2', :controller => 'default_views_test/not_used', :action => 'show2'
    map.connect 'show3', :controller => 'default_views_test/not_used', :action => 'show3'
    map.connect 'show4', :controller => 'default_views_test/not_used', :action => 'show4'
  end
  
  tests NotUsedController
  
  def test_controller_action_with_controller_partial
    get :show1
    assert_response :success
  end
  
  def test_default_action_with_controller_partial
    get :show2
    assert_response :success
  end
  
  def test_controller_action_with_default_partial
    get :show3
    assert_response :success
  end
  
  def test_default_action_with_default_partial
    get :show4
    assert_response :success
  end
end
