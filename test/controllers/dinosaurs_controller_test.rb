require 'test_helper'

class DinosaursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dinosaur = dinosaurs(:one)
  end

  test "should get index" do
    get dinosaurs_url, as: :json
    assert_response :success
  end

  test "should create dinosaur" do
    assert_difference('Dinosaur.count') do
      post dinosaurs_url, params: { dinosaur: { name: "mike", species: "ankylosaurus", cage_id: 1} }, as: :json
    end

    assert_response 201
  end

  test "should throw error cause no name" do
    post dinosaurs_url, params: { dinosaur: { species: "ankylosaurus", cage_id: 1} }, as: :json
    assert_response 422
  end

  test "should create carnivorous dinosaur" do
    post dinosaurs_url, params: { dinosaur: { name: "sarah", species: "Tyrannosaurus", cage_id: 1} }, as: :json
    assert JSON.parse(@response.body)["is_carnivore"]
  end

  test "should create herbivore dinosaur" do
    post dinosaurs_url, params: { dinosaur: { name: "sasha", species: "triceratops", cage_id: 1} }, as: :json
    assert_not JSON.parse(@response.body)["is_carnivore"]
  end

  test "can't create dinosaur with invalid species" do
    post dinosaurs_url, params: { dinosaur: { name: "moose", species: "bulldog", cage_id: 1} }, as: :json
    assert_response 422
  end

  test "should show dinosaur" do
    get dinosaur_url(@dinosaur), as: :json
    assert_response :success
  end

  test "should update dinosaur" do
    patch dinosaur_url(@dinosaur), params: { dinosaur: { name => "Mike"  } }, as: :json
    assert_response 200
  end

  test "should destroy dinosaur" do
    assert_difference('Dinosaur.count', -1) do
      delete dinosaur_url(@dinosaur), as: :json
    end

    assert_response 204
  end
end
