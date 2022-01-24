require 'rails_helper'

RSpec.describe "Projects", type: :request do

  before(:all) do
    @user1 = User.create!(first_name: "manish",last_name: "Shrestha", email: "mshr1@example.com", password: "changeme")
    @user2 = User.create!(first_name: "prabin",last_name: "Silwal", email: "psi@example.com", password: "changeme")
    @project1 = Project.create!(title: "Project title A", project_type: 0, location: "locationA", thumbnail: "thumbnailA",
                               user_id: @user1.id)
    @project2 = Project.create!(title: "Project title B", project_type: 1, location: "locationB", thumbnail: "thumbnailB",
                               user_id: @user1.id)
    @project3 = Project.create!(title: "Project title C", project_type: 1, location: "locationC", thumbnail: "thumbnailC",
                                user_id: @user2.id)
  end



  describe "POST /api/v1/projects, Create a Project" do
    it "returns unauthorised response code, when auth token is not presented" do
      post "/api/v1/projects"
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http success, when auth token is presented, along with required params" do
      token = JWT.encode({user_id: @user1.id}, 'yourSecret')  # TODO: find better way
      headers = { "Authorization" => "Bearer #{token}" }
      req_body = {
        "title": "Title A5",
        "description": "description A1",
        "type": "external",
        "location": "Nepal",
        "thumbnail": "thumbnailA5"
      }

      post "/api/v1/projects", :params => req_body, :headers => headers
      expect(response).to have_http_status(:success)
    end

    it "returns error, when auth token is presented, but required param is not preset"

  end

  describe "GET /api/v1/projects, Get all projects" do
    it "returns http success along with all the projects" do
      get "/api/v1/projects"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("data")
      expect(response.content_type).to include("application/json")
      expect(response.body).to include("Project title A")
      expect(response.body).to include("Project title B")
    end
  end

  describe "GET /api/v1/projects/my_projects, Get all owned projects" do
    it "returns http success along with all the owned projects" do
      token = JWT.encode({user_id: @user1.id}, 'yourSecret')  # TODO: find better way
      headers = { "Authorization" => "Bearer #{token}" }

      get "/api/v1/projects/my_projects", :headers => headers
      expect(response).to have_http_status(:success)
      expect(response.body).to include("data")
      expect(response.content_type).to include("application/json")
      expect(response.body).to include("Project title A")
      expect(response.body).to include("Project title B")
    end

    it "returns error, if not logged in"
  end

  describe "GET /api/v1/projects/:id, Get a project" do
    it "returns http success for an existing project, along with the mentioned project detail" do
      get "/api/v1/projects/#{@project1.id}"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Project title A")
      expect(response.body).to include("locationA")
    end

    it "returns http success for non-existing project, along with error message" do
      get "/api/v1/projects/#{@project1.id+1000}"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Project does not exists")
    end
  end

  #
  # describe "GET /update" do
  #   it "returns http success" do
  #     get "/projects/update"
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET /delete" do
  #   it "returns http success" do
  #     get "/projects/delete"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  after(:context) do
    @project1.destroy
    @project2.destroy
    @project3.destroy
    @user1.destroy
    @user2.destroy
  end

end
