require "rails_helper"

describe Api::V1::ProjectsController do
  describe "#index" do
    let!(:project_1) { create :project }
    let!(:project_2) { create :project }
    let!(:project_3) { create :project }

    context "user is logged in" do
      it "returns all projects" do
        create_user

        get :index

        expect(response.status).to eq 200
        expect(JSON.parse(response.body, { symbolize_names: true })).to match_array([{
          id: project_1.id,
          name: project_1.name,
        }, {
          id: project_2.id,
          name: project_2.name,
        }, {
          id: project_3.id,
          name: project_3.name,
        }])
      end
    end

    context "user is NOT logged in" do
      it "returns Unauthorized" do
        get :index
        expect(response.status).to eq 401
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({ error: "Not Authorized" })
      end
    end
  end


  describe "#show" do
    let!(:project_1) { create :project }

    context "user is logged in" do
      it "returns project" do
        create_user

        get :show, params: { id: project_1.id }
        expect(response.status).to eq 200
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({
          id: project_1.id,
          name: project_1.name,
        })
      end
    end

    context "user is NOT logged in" do
      it "returns Unauthorized" do
        get :show, params: { id: project_1.id }
        expect(response.status).to eq 401
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({ error: "Not Authorized" })
      end
    end
  end


  describe "#create" do
    let!(:attrs) { attributes_for(:project) }

    context "admin user is logged in" do
      it "returns newly created project" do
        expect(Project.count).to eq(0)
        create_admin_user
        post :create, params: attrs
        project = Project.last
        expect(response.status).to eq 201
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({
          id: project.id,
          name: project.name,
        })
        expect(Project.count).to eq(1)
      end
    end

    context "user is logged in" do
      it "returns forbidden" do
        expect(Project.count).to eq(0)
        create_user
        post :create, params: attrs
        expect(response.status).to eq 403
        expect(Project.count).to eq(0)
      end
    end

    context "user is NOT logged in" do
      it "returns Unauthorized" do
        expect(Project.count).to eq(0)
        post :create, params: attrs
        expect(response.status).to eq 401
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({ error: "Not Authorized" })
        expect(Project.count).to eq(0)
      end
    end
  end


  describe "#update" do
    let!(:project_1) { create :project }

    context "admin user is logged in" do
      it "returns updated project" do
        create_admin_user

        put :update, params: {
          id: project_1.id,
          name: "updated name"
        }

        expect(response.status).to eq 200
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({
          id: project_1.id,
          name: "updated name",
        })
        expect(project_1.reload.name).to eq("updated name")
      end
    end

    context "user is logged in" do
      it "returns forbidden" do
        project_1_name = project_1.name
        create_user
        put :update, params: {
          id: project_1.id,
          name: "updated name"
        }
        expect(response.status).to eq 403
        expect(project_1.reload.name).to eq(project_1_name)
      end
    end

    context "user is NOT logged in" do
      it "returns Unauthorized" do
        project_1_name = project_1.name
        put :update, params: {
          id: project_1.id,
          name: "updated name"
        }
        expect(response.status).to eq 401
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({ error: "Not Authorized" })
        expect(project_1.reload.name).to eq(project_1_name)
      end
    end
  end


  describe "#destroy" do
    let!(:project_1) { create :project }

    context "admin user is logged in" do
      it "returns no content" do
        expect(Project.count).to eq(1)
        create_admin_user
        delete :destroy, params: { id: project_1.id }
        expect(response.status).to eq 204
        expect(Project.count).to eq(0)
      end
    end

    context "user is logged in" do
      it "returns forbidden" do
        expect(Project.count).to eq(1)
        create_user
        delete :destroy, params: { id: project_1.id }
        expect(response.status).to eq 403
        expect(Project.count).to eq(1)
      end
    end

    context "user is NOT logged in" do
      it "returns Unauthorized" do
        expect(Project.count).to eq(1)
        delete :destroy, params: { id: project_1.id }
        expect(response.status).to eq 401
        expect(JSON.parse(response.body, { symbolize_names: true })).to eq({ error: "Not Authorized" })
        expect(Project.count).to eq(1)
      end
    end
  end
end
