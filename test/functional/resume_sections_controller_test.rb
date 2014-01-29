require 'test_helper'

class ResumeSectionsControllerTest < ActionController::TestCase
  setup do
    @resume_section = resume_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resume_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resume_section" do
    assert_difference('ResumeSection.count') do
      post :create, resume_section: {  }
    end

    assert_redirected_to resume_section_path(assigns(:resume_section))
  end

  test "should show resume_section" do
    get :show, id: @resume_section
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resume_section
    assert_response :success
  end

  test "should update resume_section" do
    put :update, id: @resume_section, resume_section: {  }
    assert_redirected_to resume_section_path(assigns(:resume_section))
  end

  test "should destroy resume_section" do
    assert_difference('ResumeSection.count', -1) do
      delete :destroy, id: @resume_section
    end

    assert_redirected_to resume_sections_path
  end
end
