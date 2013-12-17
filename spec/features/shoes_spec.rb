require 'spec_helper'

feature "View shoes" do

  background do
    @color = Color.create!(name: 'color_name')
    @shoe = Shoe.create!(name: 'shoe_name', size: 10.5, color_id: @color.id)
  end

  scenario "list all shoes and interface links" do
    visit shoes_url
    expect(page).to have_content('Shoes')
    expect(page).to have_content('Add new shoe')
    within "#shoe_record_#{@shoe.id}" do
      expect(page).to have_content('shoe_name')
      expect(page).to have_content('Destroy shoe')
      expect(page).to have_content('Edit shoe')
      expect(page).to have_content('Show shoe')
      expect(page).to have_content('10.5')
      expect(page).to have_content('color_name')
    end
  end

  scenario "show parts collection" do
    partype = Partype.create!(name: 'partype_name')
    part = Part.create!(partype_id: partype.id, shoe_id: @shoe.id)
    visit shoes_url
    within "#shoe_record_#{@shoe.id}" do
      expect(page).to have_content(part.name)
    end
  end

end

feature "Manage shoes" do

  background do
    @shoe = Shoe.create!(name: 'shoe_name')
  end


  scenario "add a new shoe and display the results" do
    visit shoes_url
    expect{
      click_link 'Add new shoe'
      fill_in 'Name', with: "second_shoe"
      click_button "Save"
    }.to change(Shoe,:count).by(1)

    expect(page).to have_content "Shoe was successfully created."
    expect(page).to have_content "second_shoe"
  end

  scenario "edit a shoe and display the updated record" do
    visit shoes_url

    within "#shoe_record_#{@shoe.id}" do
      click_link 'Edit shoe'
    end
    fill_in 'Name', with: 'change_shoe'
    click_button 'Save'

    expect(page).to have_content 'Shoe was successfully updated'
    expect(page).to have_content 'change_shoe'
  end

  scenario "delete a shoe" do
    visit shoes_url
    expect{
      within "#shoe_record_#{@shoe.id}" do
        click_link 'Destroy shoe'
      end
    }.to change(Shoe,:count).by(-1)
    expect(page).to have_content "Shoes"
    expect(page).to_not have_content "shoe_name"
  end

  scenario "show the shoe" do
    visit shoes_url
    within "#shoe_record_#{@shoe.id}" do
      click_link 'Show shoe'
    end
    expect(page).to have_content "Shoe"
    expect(page).to have_content "shoe_name"
  end

end

feature 'Manage shoes colors' do

  background do
    @shoe = Shoe.create!(name: 'shoe_name')
  end

  scenario "create new shoe and select color" do
    color = Color.create!(name: 'color_name')
    visit shoes_url
    click_link 'Add new shoe'
    click_link 'Select color'
    within "#color_record_#{color.id}" do
      click_link 'Select color'
    end
    fill_in 'Name', with: 'shoe_name'
    click_button 'Save'

    expect(page).to have_content 'Shoe was successfully created'
    expect(page).to have_content 'shoe_name'
    expect(page).to have_content 'color_name'
  end

  scenario "edit shoe and select color" do
    color = Color.create!(name: 'color_name')
    visit shoes_url
    within "#shoe_record_#{@shoe.id}" do
      click_link 'Edit shoe'
    end
    click_link 'Select color'
    within "#color_record_#{color.id}" do
      click_link 'Select color'
    end
    click_button 'Save'

    expect(page).to have_content 'Shoe was successfully updated'
    expect(page).to have_content 'shoe_name'
    expect(page).to have_content 'color_name'
  end

end

feature 'Manage shoe parts' do

  background do
    @shoe = Shoe.create!(name: 'shoe_name')
    @partype = Partype.create!(name: 'partype_name')
    @part= Part.create!(partype_id: @partype.id, shoe_id: @shoe.id)
  end

  scenario "edit parts from shoe/edit" do
    visit shoes_url
    within "#shoe_record_#{@shoe.id}" do
      expect(page).to have_content @partype.name
      click_link 'Edit shoe'
    end
    click_link 'Edit parts collection'

    expect(page).to have_content @partype.name
  end

end
