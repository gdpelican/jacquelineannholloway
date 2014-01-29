require 'test_helper'

class IntroBlurbsControllerTest < ActionController::TestCase
  setup do
    @intro_blurb = intro_blurbs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:intro_blurbs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create intro_blurb" do
    assert_difference('IntroBlurb.count') do
      post :create, intro_blurb: {  }
    end

    assert_redirected_to intro_blurb_path(assigns(:intro_blurb))
  end

  test "should show intro_blurb" do
    get :show, id: @intro_blurb
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @intro_blurb
    assert_response :success
  end

  test "should update intro_blurb" do
    put :update, id: @intro_blurb, intro_blurb: {  }
    assert_redirected_to intro_blurb_path(assigns(:intro_blurb))
  end

  test "should destroy intro_blurb" do
    assert_difference('IntroBlurb.count', -1) do
      delete :destroy, id: @intro_blurb
    end

    assert_redirected_to intro_blurbs_path
  end
end
