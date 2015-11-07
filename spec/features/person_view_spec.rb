require 'rails_helper'

describe 'the person view', type: :feature do
  describe 'phone numbers' do
    describe 'email addresses' do

      let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

      before(:each) do
        person.email_addresses.create(address: 'josh@example.com')
        person.email_addresses.create(address: 'john@example.com' )
      end

      before(:each) do
        person.phone_numbers.create(number: "555-1234")
        person.phone_numbers.create(number: "555-5678")
        visit person_path(person)
      end

      it 'shows the phone numbers' do
        person.phone_numbers.each do |phone|
          expect(page).to have_content(phone.number)
        end
      end

      it 'has a link to add a new phone number' do
        expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: person.id, contact_type: "Person"))
      end

      it 'adds a new phone number' do
        page.click_link('Add phone number')
        page.fill_in('Number', with: '555-8888')
        page.click_button('Create Phone number')
        expect(current_path).to eq(person_path(person))
        expect(page).to have_content('555-8888')
      end

      it 'has links to edit phone numbers' do
        person.phone_numbers.each do |phone|
          expect(page).to have_link('edit', href: edit_phone_number_path(phone))
        end
      end

      it 'edits a phone number' do
        phone = person.phone_numbers.first
        old_number = phone.number

        first(:link, 'edit').click
        page.fill_in('Number', with: '555-9191')
        page.click_button('Update Phone number')
        expect(current_path).to eq(person_path(person))
        expect(page).to have_content('555-9191')
        expect(page).to_not have_content(old_number)
      end

      it 'has links to delete a phone number' do
        person.phone_numbers.each do |phone|
          expect(page).to have_link('delete', phone_number_path(phone))
        end
      end

      it 'deletes a phone number' do
        first(:link, 'delete').click
        expect(page).to_not have_content('555-1234')
      end


      it "show the email addresses" do
        person.email_addresses.each do |email|
          expect(page).to have_selector("li", text: "#{email.address}")
        end
      end

      it 'has a link for each email address' do
        expect(page).to have_selector('li', text: 'josh@example.com')
      end

      it 'it has an email address link' do
        save_and_open_page
        expect(page).to have_link('Add email address', href: new_email_address_path( contact_type: "Person"))
      end

      it 'adds a new email address' do
        page.click_link('Add email address')
        page.fill_in("Address", with: 'test@example.com')
        page.click_button('Create Email address')
        expect(current_path).to eq(person_path(person))
        expect(page).to have_content('test@example.com')
      end

      it 'has links to edit an email address' do
        person.email_addresses.each do |email|
          expect(page).to have_link('edit', href: edit_email_address_path(email))
        end
      end

      it 'edits an email address' do
        email = person.email_addresses.first
        old_email = email.address

        within(".show-email") do
          first(:link, 'edit').click
        end

        page.fill_in('Address', with: 'test@me.com')
        page.click_button('Update')
        expect(current_path).to eq(person_path(person))
        expect(page).to have_content('test@me.com')
        expect(page).not_to have_content(old_email)
      end

      it "has a link to delete phone numbers" do
        person.email_addresses.each do |email|
          expect(page).to have_link('delete', email_address_path(email))
        end
      end

    end #email addresses
  end #phone numbers
end #person view
