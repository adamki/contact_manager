require 'rails_helper'

RSpec.describe EmailAddress, type: :model do

  let(:person) do
    Person.new(first_name: 'Alice', last_name: 'Smith')
  end

  it 'has an array of email addresses ' do
    expect(person.email_addresses).to eq([])
  end

end
