require "application_system_test_case"

class UserSitesTest < ApplicationSystemTestCase
  setup do
    @user_site = user_sites(:one)
  end

  test "visiting the index" do
    visit user_sites_url
    assert_selector "h1", text: "User Sites"
  end

  test "creating a User site" do
    visit user_sites_url
    click_on "New User Site"

    fill_in "Site", with: @user_site.site_id
    fill_in "User", with: @user_site.user_id
    click_on "Create User site"

    assert_text "User site was successfully created"
    click_on "Back"
  end

  test "updating a User site" do
    visit user_sites_url
    click_on "Edit", match: :first

    fill_in "Site", with: @user_site.site_id
    fill_in "User", with: @user_site.user_id
    click_on "Update User site"

    assert_text "User site was successfully updated"
    click_on "Back"
  end

  test "destroying a User site" do
    visit user_sites_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User site was successfully destroyed"
  end
end
