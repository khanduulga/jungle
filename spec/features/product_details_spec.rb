require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature do
  #SETUP
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

  scenario "homepage" do
    # ACT
    visit root_path
    click_on 'Details'
    

    # DEBUG / VERIFY
    expect(page).to have_css 'section.products-index'
    expect(page).to have_css 'article.product-detail'

    save_screenshot
  end
end
