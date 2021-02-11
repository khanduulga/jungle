require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
    )

  end

  scenario "adds product to cart and 'My Cart' updates with item count" do
    # ACT
    visit root_path
    click_on 'Add'
    

    # DEBUG / VERIFY
    expect(page).to have_text 'My Cart (1)'

    # save_screenshot
  end
end
