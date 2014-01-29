require 'test_helper'

class ResumeItemsControllerTest < ActionController::TestCase
  setup do
    @resume_item = resume_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resume_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resume_item" do
    assert_difference('ResumeItem.count') do
      post :create, resume_item: {  }
    end

    assert_redirected_to resume_item_path(assigns(:resume_item))
  end

  test "should show resume_item" do
    get :show, id: @resume_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resume_item
    assert_response :success
  end

  test "should update resume_item" do
    put :update, id: @resume_item, resume_item: {  }
    assert_redirected_to resume_item_path(assigns(:resume_item))
  end

  test "should destroy resume_item" do
    assert_difference('ResumeItem.count', -1) do
      delete :destroy, id: @resume_item
    end

    assert_redirected_to resume_items_path
  end
end
