require 'test_helper'

class PrivacySettingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:privacy_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create privacy_setting" do
    assert_difference('PrivacySetting.count') do
      post :create, :privacy_setting => { }
    end

    assert_redirected_to privacy_setting_path(assigns(:privacy_setting))
  end

  test "should show privacy_setting" do
    get :show, :id => privacy_settings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => privacy_settings(:one).to_param
    assert_response :success
  end

  test "should update privacy_setting" do
    put :update, :id => privacy_settings(:one).to_param, :privacy_setting => { }
    assert_redirected_to privacy_setting_path(assigns(:privacy_setting))
  end

  test "should destroy privacy_setting" do
    assert_difference('PrivacySetting.count', -1) do
      delete :destroy, :id => privacy_settings(:one).to_param
    end

    assert_redirected_to privacy_settings_path
  end
end
