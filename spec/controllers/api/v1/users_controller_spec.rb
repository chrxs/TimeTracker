require "rails_helper"

describe Api::V1::UsersController do
  describe "#index" do
    let!(:user_1) { create :user }
    let!(:user_2) { create :user }
    let!(:user_3) { create :user }

    context "as admin user" do
      it "should return all users" do
        admin_user = create_admin_user
        get :index
        expect(JSON.parse(response.body, { symbolize_names: true })).to match_array([{
          id: admin_user.id,
          email: admin_user.email,
          name: admin_user.name,
          image: admin_user.image,
          is_admin: admin_user.is_admin,
        }, {
          id: user_1.id,
          email: user_1.email,
          name: user_1.name,
          image: user_1.image,
          is_admin: user_1.is_admin,
        }, {
          id: user_2.id,
          email: user_2.email,
          name: user_2.name,
          image: user_2.image,
          is_admin: user_2.is_admin,
        }, {
          id: user_3.id,
          email: user_3.email,
          name: user_3.name,
          image: user_3.image,
          is_admin: user_3.is_admin,
        }])
      end
    end

    context "as user" do
      it "should return forbidden" do
        user = create_user
        get :index
        expect(response.status).to eq 403
      end
    end

    context "not logged in" do
      it "should return Unauthorized" do
        get :index
        expect(response.status).to eq 401
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({ error: "Not Authorized" })
      end
    end
  end


  describe "#show" do
    let!(:user_1) { create :user }

    context "as admin user" do
      it "should return the user" do
        admin_user = create_admin_user
        get :show, params: { id: user_1.id }
        expect(response.status).to eq 200
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({
          id: user_1.id,
          email: user_1.email,
          name: user_1.name,
          image: user_1.image,
          is_admin: user_1.is_admin,
        })
      end
    end

    context "as user" do
      it "should return forbidden" do
        user = create_user
        get :show, params: { id: user_1.id }
        expect(response.status).to eq 403
      end
    end

    context "not logged in" do
      it "should return Unauthorized" do
        get :show, params: { id: user_1.id }
        expect(response.status).to eq 401
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({ error: "Not Authorized" })
      end
    end
  end


  describe "#myself" do
    context "as admin user" do
      it "should return myself" do
        admin_user = create_admin_user
        get :myself
        expect(response.status).to eq 200
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({
          id: admin_user.id,
          email: admin_user.email,
          name: admin_user.name,
          image: admin_user.image,
          is_admin: admin_user.is_admin,
        })
      end
    end

    context "as user" do
      it "should return myself" do
        user = create_user
        get :myself
        expect(response.status).to eq 200
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({
          id: user.id,
          email: user.email,
          name: user.name,
          image: user.image,
          is_admin: user.is_admin,
        })
      end
    end

    context "not logged in" do
      it "should return Unauthorized" do
        get :myself
        expect(response.status).to eq 401
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({ error: "Not Authorized" })
      end
    end
  end
end
