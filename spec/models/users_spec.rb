require 'rails_helper'

# To run all tests in your application:
# `rspec`

# To run tests of a specific file:
# `rspec path/to/file` (e.g. `rspec spec/models/user_spec.rb`)

# To a specific test:
# `rspec path/to/file:line_number_of_it` (e.g. `rspec spec/models/user_spec.rb:15`)

RSpec.describe User, type: :model do

  # it 'validates first_name exists' do
  #   u = User.new
  #   u.valid?
  #   expect(u.errors).to have_key(:first_name)
  # end

  def valid_user
    @user ||= User.new first_name: 'Jon', last_name: 'Snow', email: 'js@winterfell.gov'
    # @user =  @user || User.new first_na...
  end

  describe 'validations' do
    # EXERCISE: check that first_name exists and that last_name exists
    describe 'first_name' do
      it 'must be present' do
        # Given
        u = valid_user
        # When no first name
        u.first_name = nil
        # Then (errors should have key title)
        u.valid?
        expect(u.errors).to have_key(:first_name)
      end
    end

    describe 'last_name' do
      it 'must be present' do
        # u = User.new
        u = valid_user
        u.last_name = nil
        u.valid?
        expect(u.errors).to have_key(:last_name)
      end
    end



    describe 'email' do
      it('must be present') do
        # Given (a new user without a title)
        u = User.new
        # When
        u.valid?
        # Then (errors should have key title)
        expect(u.errors).to have_key(:email)
      end

      it 'must be unique' do
        # Given
        u = User.create first_name: 'Jon', last_name: 'Snow', email: 'test@test.ca'
        u1 = User.new email: 'test@test.ca'
        # When
        u1.valid?
        # Then
        expect(u1.errors).to have_key(:email)
      end
    end
  end

  describe '#full_name' do
    it 'combines first_name and last_name' do
      # Given (a valid user with first_name and last_name)
      u = User.new email: 'test@test.ca', first_name: 'Jon', last_name: 'Snow'

      # Then (use the full_name)
      expected_value = u.full_name

      expect(expected_value).to eq('Jon Snow')
    end

    it 'trims white space' do
      u = User.new email: 'test@test.ca', first_name: '  Jon', last_name: '  Snow  '
      expected_value = u.full_name
      expect(expected_value).to eq('Jon Snow')
    end
  end
end
