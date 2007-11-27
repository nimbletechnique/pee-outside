require File.dirname(__FILE__) + '/../test_helper'
require 'pee_controller'

# Re-raise errors caught by the controller.
class PeeController; def rescue_action(e) raise e end; end

class PeeControllerTest < Test::Unit::TestCase
  def setup
    @controller = PeeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
