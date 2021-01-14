require 'test_helper'

class DinosaursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dinosaur = dinosaurs(:one)
    @tina = dinosaurs(:tina)
    @roger = dinosaurs(:roger)
  end

  test "should get index" do
    get dinosaurs_url, as: :json
    assert_response :success
  end

  test "should get all t-rexs" do
    get "/dinosaurs?query=tyrannosaurus"
    results = JSON.parse(@response.body)
    results.each do |res|
      flunk("returned not t-rex") unless res["species"] == "tyrannosaurus"
    end
    assert true
  end

  test "should get all ankys" do
    get "/dinosaurs?query=ankylosaurus"
    results = JSON.parse(@response.body)
    results.each do |res|
      flunk("returned not t-rex") unless res["species"] == "ankylosaurus"
    end
    assert true
  end

  test "should return all if query is bad" do
    get "/dinosaurs?query=madeup"
    assert @response.body.present?
  end

  test "should create dinosaur" do
    assert_difference('Dinosaur.count') do
      post dinosaurs_url, params: { dinosaur: { name: "mike", species: "ankylosaurus", cage_id: 9} }, as: :json
    end

    assert_response 201
  end

  test "should throw error cause no name" do
    post dinosaurs_url, params: { dinosaur: { species: "ankylosaurus", cage_id: 9} }, as: :json
    assert_response 422
  end

  test "should create carnivorous dinosaur" do
    post dinosaurs_url, params: { dinosaur: { name: "sarah", species: "Tyrannosaurus", cage_id: 9} }, as: :json
    assert JSON.parse(@response.body)["is_carnivore"]
  end

  test "should create herbivore dinosaur" do
    post dinosaurs_url, params: { dinosaur: { name: "sasha", species: "triceratops"} }, as: :json
    assert_not JSON.parse(@response.body)["is_carnivore"]
  end

  test "can't create dinosaur with invalid species" do
    post dinosaurs_url, params: { dinosaur: { name: "moose", species: "bulldog"} }, as: :json
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

  test "put herbivore in herbivore cage" do
    patch put_in_cage_dinosaur_url(@tina), params: { dinosaur: { cage_id: 5 } }, as: :json
    assert_response 200
  end

  test "can't move herbivore to full herbivore cage" do
    patch put_in_cage_dinosaur_url(@tina), params: { dinosaur: { cage_id: 6 } }, as: :json
    assert_response 422
  end

  test "can't move herbivore to carnivore cage" do
    patch put_in_cage_dinosaur_url(@tina), params: { dinosaur: { cage_id: 7 } }, as: :json
    assert_response 422
  end

  test "can't move to down cage" do
    patch put_in_cage_dinosaur_url(@tina), params: { dinosaur: { cage_id: 1 } }, as: :json
    assert_response 422
  end

  test "put carnivore in cage with species" do
    patch put_in_cage_dinosaur_url(@roger), params: { dinosaur: { cage_id: 7 } }, as: :json
    assert_response 200  
  end

  test "can't put carnivore in cage with different carnivore species" do
    patch put_in_cage_dinosaur_url(@roger), params: { dinosaur: { cage_id: 8 } }, as: :json
    assert_response 422
  end

  test "can't put carnivore in cage with herbivore" do
    patch put_in_cage_dinosaur_url(@roger), params: { dinosaur: { cage_id: 5 } }, as: :json
    assert_response 422
  end

end
