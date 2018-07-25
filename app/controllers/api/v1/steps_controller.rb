module Api::V1
	class StepsController < ApplicationController
		before_action :authenticate_user, only: [:create, :update, :destroy]

		def create
			@step = Step.create(step_params)
			render json: @step
		end
		def update
			@step = Step.find(params[:id])
			@step.update_attributes(step_params)
			render json: @step
		end
		def destroy
			@step = Step.find(params[:id])
			if @step.destroy
				head :no_content, status: :ok
			else
				render json: @step.errors, status: :unprocessable_entity
			end
		end
		def current
			@steps = Step.where(current: true).where(complete: false)
			render json: @steps, include: ['project']
		end
		def complete
			@steps = Step.where(complete: true).order('updated_at desc').limit(10)
			render json: @steps, include: ['project']
		end
		def index
			@steps = Step.order("order asc")
			render json: @steps
		end

		private

		def step_params
			params.require(:step).permit(
				:project_id,
				:step_text,
				:complete,
				:category,
				:current,
				:notes,
				:order
			)
		end
	end
end