require 'test_helper'

class ProfileImagesControllerTest < ActionController::TestCase
  setup do
    @profile_image = profile_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_image" do
    assert_difference('ProfileImage.count') do
      post :create, profile_image: {  }
    end

    assert_redirected_to profile_image_path(assigns(:profile_image))
  end

  test "should show profile_image" do
    get :show, id: @profile_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_image
    assert_response :success
  end

  test "should update profile_image" do
    put :update, id: @profile_image, profile_image: {  }
    assert_redirected_to profile_image_path(assigns(:profile_image))
  end

  test "should destroy profile_image" do
    assert_difference('ProfileImage.count', -1) do
      delete :destroy, id: @profile_image
    end

    assert_redirected_to profile_images_path
  end
end
