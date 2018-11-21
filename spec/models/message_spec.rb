require 'rails_helper'

RSpec.describe Message, type: :model do 
    it 'shuld have proper attributes' do
        expect(subject.attributes).to include('content', 'user_id', 'created_at', 'updated_at')
    end

    describe 'validations' do
        it {should validate_presence_of(:content) }
        it {should validate_length_of(:content).is_at_most(140) }
    end

    describe 'relations' do
        it {should belong_to(:user)}
        it {should have_many(:comments)}
    end

    it 'should require content' do
        user = User.create(email: 'test@test.pl', password: 'Testtest1')
        expect(Message.new( user_id: user.id)).not_to be_valid
    end

    it 'should have content shorter than 140 chars' do
        user = User.create(email: 'test@test.pl', password: 'Testtest1')
        expect(Message.new(content: 'test', user_id: user.id)).to be_valid
        expect(Message.new(content: 'test' * 100,  user_id: user.id)).not_to be_valid
    end


end