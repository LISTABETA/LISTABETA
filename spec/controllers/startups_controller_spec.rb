require 'spec_helper'

RSpec.describe StartupsController, type: :controller do
  let(:user) { create(:user) }
  let(:startup) { create(:startup, :published) }
  let!(:startups) { create_list(:startup, 10, :published) }

  describe 'GET #index' do
    context 'when user logged in' do
      before do
        login(user)
        get :index
      end

      it { is_expected.to respond_with(:ok) }
      it { expect(assigns(:startups).count).to eq(10) }
    end

    context 'when user logged out' do
      before do
        login(nil)
        get :index
      end

      it { is_expected.to respond_with(:ok) }
      it { expect(assigns(:startups).count).to eq(10) }
    end
  end

  describe 'GET #show' do
    context 'when user logged in' do
      before do
        login(user)
        get :show, id: startup.id
      end

      it { is_expected.to respond_with(:ok) }
      it { expect(assigns(:startup)).to eq(startup) }
    end

    context 'when user logged out' do
      before do
        login(nil)
        get :show, id: startup.id
      end

      it { is_expected.to respond_with(:ok) }
      it { expect(assigns(:startup)).to eq(startup) }
    end
  end
end
