class AssetsController < ApplicationController
	def index
		assets=Asset.all
		render json: {status: 'SUCCESS', message: 'Assets list', 
			          data: assets},status: :ok
	end

	def show
		asset=Asset.find(params[:id])
		render json: {status: 'SUCCESS', message: 'Asset information', 
			          data: asset},status: :ok

	end	

	def create
		asset=Asset.new(asset_params)

		if asset.save
			render json: {status: 'SUCCESS', message: 'Asset added', 
				          data: asset},status: :ok
		else
		render json: {status: 'ERROR', message: 'Asset not added',
		              data: article.errors},status: :unprocessale_entity
 		end
	end	

	def update
		asset=Asset.find(params[:id])
		if asset.update_attributes(asset_params)
			render json: {status: 'SUCCESS', message: 'Asset updated', 
				          data: asset},status: :ok
		else
			render json: {status: 'ERROR', message: 'Asset not updated', 
				data:asset.errors},status: :unprocessale_entity
		end	


	end	

	def destroy
        por=Portfolio.find(params[:id])
		por.destroy
		#asset=Asset.find(params[:id])
		#asset.destroy
		render json: {status: 'SUCCESS', message: 'Asset deleted',
		 data: por},status: :ok

	end	

	private

	def asset_params
		params.permit(:name, :price)
	end	
end
