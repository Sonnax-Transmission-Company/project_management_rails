module Api::V1
	class ProjectsController < ApplicationController
		before_action :authenticate_user
		def create
			@project = Project.create(project_params)
			render json: @project
		end
		def show
			@project = Project.find(params[:id])
			@steps = @project.steps
			if @steps
				render json: @steps
			else
				head :no_content, status: :ok
			end
		end
		def update
			set_object_params
			@project = Project.find(params[:id])
			@project.update_attributes(project_params)
			render json: @project, include: ['steps']
		end
		def destroy
			@project = Project.find(params[:id])
			if @project.destroy
				head :no_content, status: :ok
			else
				render json: @project.errors, status: :unprocessable_entity
			end
		end
		def index
			@projects = Project.order("priority desc")
			render json: @projects, include: ['steps']
		end

		private

		def set_object_params
			if params[:project][:complete_date].present?
				params[:project][:complete_date] = Time.now
			end
		end

		def project_params
			params.require(:project).permit(
				:title,
				:priority,
				:request,
				:notes,
				:status,
				:product_line,
				:no_steps,
				:due_date,
				:complete_date,
				steps_attributes: [
					:id,
					:project_id,
					:step_text,
					:complete,
					:category,
					:current,
					:notes,
					:order
				]
			)
		end
	end
end