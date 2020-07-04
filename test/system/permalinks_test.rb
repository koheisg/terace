require "application_system_test_case"

class PermalinksTest < ApplicationSystemTestCase
  setup do
    @permalink = permalinks(:one)
  end

  test "visiting the index" do
    visit permalinks_url
    assert_selector "h1", text: "Permalinks"
  end

  test "creating a Permalink" do
    visit permalinks_url
    click_on "New Permalink"

    fill_in "Description", with: @permalink.description
    fill_in "Modified at", with: @permalink.modified_at
    check "Noindex" if @permalink.noindex
    fill_in "Path", with: @permalink.path
    fill_in "Permalinkable", with: @permalink.permalinkable_id
    fill_in "Permalinkable type", with: @permalink.permalinkable_type
    fill_in "Published at", with: @permalink.published_at
    fill_in "Site", with: @permalink.site_id
    fill_in "Title", with: @permalink.title
    click_on "Create Permalink"

    assert_text "Permalink was successfully created"
    click_on "Back"
  end

  test "updating a Permalink" do
    visit permalinks_url
    click_on "Edit", match: :first

    fill_in "Description", with: @permalink.description
    fill_in "Modified at", with: @permalink.modified_at
    check "Noindex" if @permalink.noindex
    fill_in "Path", with: @permalink.path
    fill_in "Permalinkable", with: @permalink.permalinkable_id
    fill_in "Permalinkable type", with: @permalink.permalinkable_type
    fill_in "Published at", with: @permalink.published_at
    fill_in "Site", with: @permalink.site_id
    fill_in "Title", with: @permalink.title
    click_on "Update Permalink"

    assert_text "Permalink was successfully updated"
    click_on "Back"
  end

  test "destroying a Permalink" do
    visit permalinks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Permalink was successfully destroyed"
  end
end
