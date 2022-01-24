require 'rails_helper'


RSpec.describe Project, type: :model do

  context 'Instantiation' do
    before(:context) do
      @owner_user = User.create(first_name: "Manish", last_name: "Shrestha", email: "abc3@example.com", password_digest: "abc")
    end


    it "is valid with a title, project_type, location, and thumbnail" do
      project = Project.new(title: "title A", project_type: 0, location: "locationA", thumbnail: "thumbnail",
                            user_id: @owner_user.id)
      expect(project.valid?).to be true
    end

    it "is invalid without a title" do
      project_wo_title = Project.new( project_type: 0, location: "locationA", thumbnail: "thumbnail",
                                      user_id: @owner_user.id)
      expect(project_wo_title.valid?).to be false
    end

    it "is invalid without a project_type" do
      project_wo_project_type = Project.new( title: "title A", location: "locationA", thumbnail: "thumbnail",
                                      user_id: @owner_user.id)
      expect(project_wo_project_type.valid?).to be false
    end

    it "is possible more than once for a given user" do
      project1 = Project.create(title: "title A", project_type: 0, location: "locationA", thumbnail: "thumbnail",
                            user_id: @owner_user.id)
      expect(project1.valid?).to be true
      project2 = Project.create(title: "title B", project_type: 1, location: "locationA", thumbnail: "thumbnail2",
                             user_id: @owner_user.id)
      expect(project2.valid?).to be true
    end



    after(:context) do
      @owner_user.destroy
    end


  end





end
