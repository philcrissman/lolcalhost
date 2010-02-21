require 'test_helper'

class CommandsControllerTest < ActionController::TestCase
  class FooCommand < Command::Base
  end

  should("pass truthitest") { assert true }

  context "POST /create" do
    should("lookup the command and render the command's to_json") do
      post :create, { :command => 'foo_command param1 param2' }

      assert_not_nil(command = assigns(:command), "Should assign to @command")

      assert_equal command.to_json, @response.body
    end

    should("404 for an unknown command") do
      post :create, { :command => 'non-existing command' }

      assert_response 404
    end
  end
end
