require 'spec_helper'

feature "View matters" do

  background do
    @matter = Matter.create!(name: 'matter_name')
  end

  scenario "list all matters and interface links" do
    visit matters_url
    expect(page).to have_content('Matters')
    expect(page).to have_content('Add new matter')
    within "#matter_record_#{@matter.id}" do
      expect(page).to have_content('matter_name')
      expect(page).to have_content('Destroy matter')
      expect(page).to have_content('Edit matter')
      expect(page).to have_content('Show matter')
    end
  end

  scenario "show partypes collection" do
    partype = Partype.create!(name: 'partype_name')
    partype.matters << @matter
    visit matters_url
    within "#matter_record_#{@matter.id}" do
      expect(page).to have_content(partype.name)
    end
  end

end

feature "Manage matters" do

  background do
    @matter = Matter.create!(name: 'matter_name')
  end


  scenario "add a new matter and display the results" do
    visit matters_url
    expect{
      click_link 'Add new matter'
      fill_in 'Name', with: "second_matter"
      click_button "Save"
    }.to change(Matter,:count).by(1)

    expect(page).to have_content "Matter was successfully created."
    expect(page).to have_content "second_matter"
  end

  scenario "edit a matter and display the updated record" do
    visit matters_url

    within "#matter_record_#{@matter.id}" do
      click_link 'Edit matter'
    end
    fill_in 'Name', with: 'change_matter'
    click_button 'Save'

    expect(page).to have_content 'Matter was successfully updated'
    expect(page).to have_content 'change_matter'
  end

  scenario "delete a matter" do
    visit matters_url
    expect{
      within "#matter_record_#{@matter.id}" do
        click_link 'Destroy matter'
      end
    }.to change(Matter,:count).by(-1)
    expect(page).to have_content "Matters"
    expect(page).to_not have_content "matter_name"
  end

  scenario "show the matter" do
    visit matters_url
    within "#matter_record_#{@matter.id}" do
      click_link 'Show matter'
    end
    expect(page).to have_content "Matter"
    expect(page).to have_content "matter_name"
  end

end
