require 'test_helper'

class CagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cage = cages(:one)
  end

  test "should get index" do
    get cages_url, as: :json
    assert_response :success
  end

  test "should create cage" do
    assert_difference('Cage.count') do
      post cages_url, params: { cage: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show cage" do
    get show_dinosaurs_cage_url(@cage), as: :json
    assert_response :success
  end

  test "should show dinosaurs" do
    get cage_url(@cage), as: :json
    assert_response :success
  end

  test "should update cage" do
    patch cage_url(@cage), params: { cage: {  } }, as: :json
    assert_response 200
  end

  test "should destroy cage" do
    assert_difference('Cage.count', -1) do
      delete cage_url(@cage), as: :json
    end

    assert_response 204
  end

  test "toggle to active" do
    @cage_two = cages(:two)
    patch toggle_power_cage_url(@cage_two)
    assert JSON.parse(@response.body)["power_status"] == "active"
  end

  test "can't toggle off when dino in cage" do
    @cage_three = cages(:three)
    patch toggle_power_cage_url(@cage_three)
    assert_response 403
  end

  test "toggle to down" do
    @cage_four = cages(:four)
    patch toggle_power_cage_url(@cage_four)
    assert JSON.parse(@response.body)["power_status"] == "down"
  end

end
