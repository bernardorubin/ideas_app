require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  def user
    @user ||= FactoryGirl.create(:user)
  end

  describe '#new' do

    context 'with no signed in user' do
      it 'redirects to the sign in page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with signed in user' do
      before do
        request.session[:user_id] = user.id
        get :new
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end

      it 'assigns a idea instance variable to a new Idea' do
        expect(assigns(:idea)).to be_a_new Idea
      end
    end
  end

  describe '#create' do

    context 'without a signed in user' do
      it 'redirects to the sign in page' do
        post :create
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with a signed in user' do
      before { request.session[:user_id] = user.id }

      context 'with valid attributes' do
        it 'creates a new idea in the database' do
          count_before = Idea.count
          post :create, params: { idea: attributes_for(:idea)}
          count_after  = Idea.count
          expect(count_after).to eq(count_before + 1)
        end

        it 'redirects to the idea show page' do
          post :create, params: { idea: attributes_for(:idea) }
          expect(response).to redirect_to(idea_path(Idea.last))
        end

        it 'associates the created idea with the signed in user' do
          post :create, params: { idea: attributes_for(:idea) }
          expect(Idea.last.user).to eq(user)
        end
      end

      context 'with invalid attributes' do
        it 'doesn\'t create a idea in the database'
        it 'renders the new template'
      end

    end
  end
end
