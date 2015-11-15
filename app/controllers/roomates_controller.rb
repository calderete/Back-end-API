class RoomatesController < ApplicationController

	def index
		@list = Roomate.where(treasurer_id: params[:treasurer_id])
		render "index.json.jbuilder"
	end
	def create
		@roomate = current_user.roomates.new(living_space: params[:living_space],
															 username: params[:username],
															 email: params[:email], 
															 name: params[:name],
															 password: params[:password])	
			render "create.json.jbuilder", status: :created
			@roomate.save
	end

	def login
		@roomate = Roomate.find_by(username: params[:username])
		if @roomate && @roomate.authenticate(params[:password])
		render "show.json.jbuilder", status: :ok
	  end
	end

	def destroy
		@roomate = Roomate.find_by(id: params[:id])
		else

	render json: {message: "#{@roomate.name} has been evicted"}, status: :ok
	end
end



