require 'rails_helper'

RSpec.describe CommentsController, type: :controller do 
    let(:user) { User.create(email: 'test@edu.p.lodz.pl', password: 'Testpassword123') }
    let(:message) { Message.create(content: 'test1', user_id: user.id) }
    before{sign_in(user)}


    describe '#show' do
        let(:comment) { Comment.create(content: 'test1', user_id: user.id, message_id: message.id )}
        before {get :show, params: {id: comment.id}}
        subject {get :show, params: {id: comment.id}}

        it 'should return successful response' do
            expect(response).to be_successful
        end

        it 'should render index template' do
            expect(response).to render_template('show')
        end

        it 'should return one comment' do
            expect(assigns(:comment)).to eq(comment)
        end
    end

    describe '#edit' do
        let(:comment) { Comment.create(content: 'test1', user_id: user.id, message_id: message.id )}
        before { get :edit, params: { id: comment.id } }
      
        describe 'succesful response' do
          it { expect(response).to be_successful }
          it { expect(response).to render_template('edit') }
        end
      
        context 'comments' do
          it { expect(assigns(:comment)).to eq(comment) }
        end
      end


      describe '#create' do
        let(:valid_attributes) {
          { comment: {
            content: 'test', user_id: user.id, message_id: message.id }
        } }
        let(:invalid_attributes) {
          { comment: {
            user_id: user.id}
        } }
    
        context 'valid params' do
          subject { post :create, params: valid_attributes }
    
          it 'should redirect to comment' do
            expect(subject).to redirect_to(message_path(id: Comment.last.id))
          end
    
          it 'should create new author' do
            expect { subject }.to change{ Comment.count }.by(1)
          end
        end
    
        # context 'invalid params' do
        #   subject { post :create, params: invalid_attributes }
    
        #   it 'should not create new author' do
        #     expect{ subject }.not_to change{ Comment.count }
        #   end
        # end
      end


      describe '#destroy' do
        let(:comment) { Comment.create(content: 'test1', user_id: user.id, message_id: message.id )}
        subject { delete :destroy, params: { id: comment.id } }
      
        it 'should redirect to comments index' do
          expect(subject).to redirect_to(comments_path)
        end
      
        it 'should destroy comment' do
          message
          expect { subject }.to change{ Comment.count }.by(-1)
        end
      end

end