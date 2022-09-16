require "application_system_test_case"

class DealersTest < ApplicationSystemTestCase
  setup do
    @dealer = dealers(:one)
  end

  test "visiting the index" do
    visit dealers_url
    assert_selector "h1", text: "Dealers"
  end

  test "should create dealer" do
    visit dealers_url
    click_on "New dealer"

    fill_in "Name", with: @dealer.name
    click_on "Create Dealer"

    assert_text "Dealer was successfully created"
    click_on "Back"
  end

  test "should update Dealer" do
    visit dealer_url(@dealer)
    click_on "Edit this dealer", match: :first

    fill_in "Name", with: @dealer.name
    click_on "Update Dealer"

    assert_text "Dealer was successfully updated"
    click_on "Back"
  end

  test "should destroy Dealer" do
    visit dealer_url(@dealer)
    click_on "Destroy this dealer", match: :first

    assert_text "Dealer was successfully destroyed"
  end
end
