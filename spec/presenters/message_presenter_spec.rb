require 'rails_helper'


RSpec.describe MessagePresenter do 

        let(:message) { Message.new(created_at: Date.new(2018, 12, 5)) }

        describe '#publication_date' do
          let(:message_presenter) { MessagePresenter.new(message) }
      
          it 'should return publication date' do
            expect(message_presenter.publication_date).to eq('Wednesday')
          end
        end
end