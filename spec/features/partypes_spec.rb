require 'spec_helper'

feature "View partypes" do

  background do
    @partype = Partype.create!(name: 'partype_name')
  end

  scenario "list all partypes and interface links" do
    visit partypes_url
    expect(page).to have_content('Partypes')
    expect(page).to have_content('Add new partype')
    within "#partype_record_#{@partype.id}" do
      expect(page).to have_content('partype_name')
      expect(page).to have_content('Destroy partype')
      expect(page).to have_content('Edit partype')
      expect(page).to have_content('Show partype')
    end
  end

  scenario "show matters collection" do
    matter = Matter.create!(name: 'matter_name')
    @partype.matters << matter
    visit partypes_url
    within "#partype_record_#{@partype.id}" do
      expect(page).to have_content(matter.name)
    end
  end

  scenario "show parts collection" do
    shoe = Shoe.create!(name: 'shoe_name')
    part = Part.create!(partype_id: @partype.id, shoe_id: shoe.id)
    visit partypes_url
    within "#partype_record_#{@partype.id}" do
      expect(page).to have_content(part.name)
    end
  end

end

feature "Manage partypes" do

  background do
    @partype = Partype.create!(name: 'partype_name')
  end


  scenario "add a new partype and display the results" do
    visit partypes_url
    expect{
      click_link 'Add new partype'
      fill_in 'Name', with: "second_partype"
      click_button "Save"
    }.to change(Partype,:count).by(1)

    expect(page).to have_content "Partype was successfully created."
    expect(page).to have_content "second_partype"
  end

  scenario "edit a partype and display the updated record" do
    visit partypes_url

    within "#partype_record_#{@partype.id}" do
      click_link 'Edit partype'
    end
    fill_in 'Name', with: 'change_partype'
    click_button 'Save'

    expect(page).to have_content 'Partype was successfully updated'
    expect(page).to have_content 'change_partype'
  end

  scenario "delete a partype" do
    visit partypes_url
    expect{
      within "#partype_record_#{@partype.id}" do
        click_link 'Destroy partype'
      end
    }.to change(Partype,:count).by(-1)
    expect(page).to have_content "Partypes"
    expect(page).to_not have_content "partype_name"
  end

  scenario "show the partype" do
    visit partypes_url
    within "#partype_record_#{@partype.id}" do
      click_link 'Show partype'
    end
    expect(page).to have_content "Partype"
    expect(page).to have_content "partype_name"
  end

end
