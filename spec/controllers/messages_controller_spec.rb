require 'rails_helper'

RSpec.describe MessagesController, type: :controller do 
    let(:user) { User.create(email: 'test@edu.p.lodz.pl', password: 'Testpassword123') }
    before{sign_in(user)}

    describe '#index' do
        subject { get :index }
        it 'should return successful response' do
            subject
            expect(response).to be_successful
        end

        it 'should render index template' do
            subject
            expect(response).to render_template('index')
        end

        it 'should return all messages' do
            message1 = Message.create(content: 'test1', user_id: user.id)
            message2 = Message.create(content: 'test2', user_id: user.id)
            subject
            expect(assigns(:messages)).to match_array([message1,message2])
        end
    end

    describe '#show' do
        let(:message) { Message.create(content: 'test1', user_id: user.id)}
        before {get :show, params: {id: message.id}}
        subject {get :show, params: {id: message.id}}

        it 'should return successful response' do
            expect(response).to be_successful
        end

        it 'should render index template' do
            expect(response).to render_template('show')
        end

        it 'should return one message' do
            expect(assigns(:message)).to eq(message)
        end

    end

    describe '#new' do
        before { get :new }
      
        describe 'succesful response' do
          it { expect(response).to be_successful }
          it { expect(response).to render_template('new') }
        end
      
        context 'message' do
          it { expect(assigns(:message)).to be_a(Message) }
          it { expect(assigns(:message).persisted?).to eq(false) }
        end
    end
      
      describe '#edit' do
        let(:message) { Message.create(content: 'content 1', user_id: user.id) }
        before { get :edit, params: { id: message.id } }
      
        describe 'succesful response' do
          it { expect(response).to be_successful }
          it { expect(response).to render_template('edit') }
        end
      
        context 'message' do
          it { expect(assigns(:message)).to eq(message) }
        end
      end

      describe '#create' do
        let(:valid_attributes) {
          { message: {
            content: 'test', user_id: user.id }
        } }
        let(:invalid_attributes) {
          { message: {
            user_id: user.id
          }
        } }
    
        context 'valid params' do
          subject { post :create, params: valid_attributes }
    
          it 'should redirect to message' do
            expect(subject).to redirect_to(message_path(id: Message.last.id))
          end
    
          it 'should create new author' do
            expect { subject }.to change{ Message.count }.by(1)
          end
        end
    
        context 'invalid params' do
          subject { post :create, params: invalid_attributes }
    
          it 'should render new' do
            expect(subject).to render_template('new')
          end
    
          it 'should not create new author' do
            expect{ subject }.not_to change{ Message.count }
          end
        end
      end
    

    describe '#update' do
        let(:message) { Message.create(content: 'content 1', user_id: user.id) }
        let(:valid_attributes) { { id: message.id, message: { content: 'new content' } } }
        let(:invalid_attributes)  { { id: message.id, message: { content: '' } } }
      
        context 'valid params' do
          subject { patch :update, params: valid_attributes }
      
          it 'should redirect to message' do
            expect(subject).to redirect_to(message_path(id: message.id))
          end
      
          it 'should change content' do
            subject
            expect(message.reload.content).to eq('new content')
          end
        end
      
        context 'invalid params' do
          subject { patch :update, params: invalid_attributes }
      
          it 'should render edit' do
            expect(subject).to render_template('edit')
          end
      
          it 'should not change content' do
            subject
            expect(message.reload.content).not_to eq('new content')
          end
        end
    end

    describe '#destroy' do
        let(:message) { Message.create(content: 'content 1', user_id: user.id) }
        subject { delete :destroy, params: { id: message.id } }
      
        it 'should redirect to messages index' do
          expect(subject).to redirect_to(messages_path)
        end
      
        it 'should destroy message' do
          message
          expect { subject }.to change{ Message.count }.by(-1)
        end
      end

end