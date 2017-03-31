require "rails_helper"

describe Api::V1::DaysController do
  describe "#index" do

    let(:day_1) { create :day, date: '2017-01-01', user: @user }
    let(:day_2) { create :day, date: '2017-01-02', user: @user }
    let(:day_3) { create :day, date: '2017-02-01', user: @user }

    context "no params" do
      it "should return all days" do
        @user = create_user
        day_1
        day_2
        day_3
        get :index
        expect(JSON.parse(response.body, { symbolize_names: true })).to match_array([{id: 300}])
      end
    end

    # context "no params" do
    # end

    # context "not logged in" do
    #   it "should return Unauthorized" do
    #     get :index
    #   end
    # end
  end


  # describe "#create" do
  #   context "as admin user" do
  #     it "" do
  #       create_admin_user
  #       post :create
  #     end
  #   end

  #   context "as user" do
  #     it "" do
  #       create_user
  #       post :create
  #     end
  #   end

  #   context "not logged in" do
  #     it "should return Unauthorized" do
  #     end
  #   end
  # end
end
