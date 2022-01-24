module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorized, only: [:create]

      def create
        project = Project.new(project_params)
        project.user = @user
        project.project_type = params[:type]

        puts("got project_params=>  #{project_params}")
        puts("got project value=>  #{project.project_type}")
        if project.valid?
          project.save

          data= {
            "id": project.id,
            "type": "project",
            "attributes": {
              "title": project.title,
              "thumbnail": project.thumbnail,
              "description": project.description,
              "location": project.location,
              "type": project.project_type,
              "ownerName": "#{project.user.first_name} #{project.user.last_name}",
              "createdAt": project.created_at,
              "updatedAt": project.updated_at
            }
          }


          render json: {data: data}
        else
          render json: {error: "Invalid values for Project"}
        end

        rescue StandardError => authentication_error
          render json: {error: "Bad arguments during Project creation"}

      end

      def index
        @projects = Project.all
        projects_modified = []

        @projects.each do |project|
          projects_modified.append(
            { "id": project.id,
              "type": "project",
              "attributes": {
                "title": project.title,
                "thumbnail": project.thumbnail,
                "description": project.description,
                "location": project.location,
                "type": project.project_type,
                "ownerName": "#{project.user.first_name} #{project.user.last_name}",
                "createdAt": project.created_at,
                "updatedAt": project.updated_at
              }
            })
        end

        resp = {
          "data": projects_modified
        }


        render json: resp
      end

      def show
        project = Project.find_by(id: params[:id])
        if !project.nil?
          data= {
            "id": project.id,
            "type": "project",
            "attributes": {
              "title": project.title,
              "thumbnail": project.thumbnail,
              "description": project.description,
              "location": project.location,
              "type": project.project_type,
              "ownerName": "#{project.user.first_name} #{project.user.last_name}",
              "createdAt": project.created_at,
              "updatedAt": project.updated_at
            }
          }
          render json: {data: data}
        else
          render json: {error: "Project does not exists"}
        end
      end

      def update
      end

      def delete
      end


      private
      def project_params
        params.require(:title)
        params.require(:type)
        params.require(:location)
        params.require(:thumbnail)
        params.permit(:title, :location, :thumbnail, :description)
      end
    end
  end
end

