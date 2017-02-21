require 'spec_helper'

describe PagesController, type: :controller do
  describe "GET home" do
    let!(:startup) { create_list(:startup, 40, :published) }

    before do
      get :home
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(assigns(:recently).count).to eql(8) }
    it { expect(assigns(:past).count).to eql(32) }
  end

  # THIS SECTION IS UNDER MAINTENANCE
  # describe "GET markets" do
  #   let(:startup) { create(:startup, :published) }
  #
  #   it "and not assign startup when pass no :tag" do
  #     get :markets
  #     expect(response).to have_http_status(:ok)
  #     expect(assigns(:markets)).not_to include(startup)
  #     expect(assigns(:markets)).to include(Startup.tag_counts_on(:markets)[1])
  #   end
  #
  #   it "and assign startup when pass no :tag" do
  #     get :markets, tag: 'Startups'
  #     expect(response).to have_http_status(:ok)
  #     expect(assigns(:startups)).to include(startup)
  #     expect(assigns(:startups)).not_to include(Startup.tag_counts_on(:markets)[1])
  #   end
  # end
end
