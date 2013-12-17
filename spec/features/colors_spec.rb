require 'spec_helper'

feature "View colors" do

  background do
    @color = Color.create!(name: 'color_name')
  end

  scenario "list all colors and interface links" do
    visit colors_url
    expect(page).to have_content('Colors')
    expect(page).to have_content('Add new color')
    within "#color_record_#{@color.id}" do
      expect(page).to have_content('color_name')
      expect(page).to have_content('Destroy color')
      expect(page).to have_content('Edit color')
      expect(page).to have_content('Show color')
    end
  end

  scenario "show shoes collection" do
    shoe = Shoe.create!(name: 'shoe_name', color_id: @color.id)
    visit colors_url
    within "#color_record_#{@color.id}" do
      expect(page).to have_content(shoe.name)
    end
  end

end

feature "Manage colors" do

  background do
    @color = Color.create!(name: 'color_name')
  end


  scenario "add a new color and display the results" do
    visit colors_url
    expect{
      click_link 'Add new color'
      fill_in 'Name', with: "second_color"
      click_button "Save"
    }.to change(Color,:count).by(1)

    expect(page).to have_content "Color was successfully created."
    expect(page).to have_content "second_color"
  end

  scenario "edit a color and display the updated record" do
    visit colors_url

    within "#color_record_#{@color.id}" do
      click_link 'Edit color'
    end
    fill_in 'Name', with: 'change_color'
    click_button 'Save'

    expect(page).to have_content 'Color was successfully updated'
    expect(page).to have_content 'change_color'
  end

  scenario "delete a color" do
    visit colors_url
    expect{
      within "#color_record_#{@color.id}" do
        click_link 'Destroy color'
      end
    }.to change(Color,:count).by(-1)
    expect(page).to have_content "Colors"
    expect(page).to_not have_content "color_name"
  end

  scenario "show the color" do
    visit colors_url
    within "#color_record_#{@color.id}" do
      click_link 'Show color'
    end
    expect(page).to have_content "Color"
    expect(page).to have_content "color_name"
  end

end
