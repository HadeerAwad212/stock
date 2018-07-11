class PortfoliosController < ApplicationController
	def create
		portfolio=Portfolio.new(portfolio_params)
	    portfolio.save
		assets=params[:assets]
		user_investments=[]
		assets.each do |asset|
			selected_asset=Asset.find(asset['asset_id'])
			user_stocks=asset['money']/selected_asset.price
			investment=Investment.new
			investment.money=asset['money']
			investment.asset_id=asset['asset_id']
			investment.stocks=user_stocks
			investment.portfolio_id=portfolio['id']
			user_investments.push(investment)
			investment.save
		end
		render json:{status: 'SUCCESS', message: 'Investments saved', 
			         investments: user_investments},status: :ok
	
	end	

	def show
		investments=Investment.where(portfolio_id: params[:id])
		investments_status=[]
		investments.each do |investment|
			asset=Asset.find(investment['asset_id'])
			price=asset.price
			current_investment={}
			current_investment['invested_money']=investment['money']
			current_investment['asset_id']=investment['asset_id']
			current_investment['current_money']=investment['stocks']*price
			investments_status.push(current_investment)
		end	
		render json: {message: 'Portfolio investments status', investments: investments_status}, status: :ok
	end	
 
    def user
    	portfolios_status=[]
    	portfolios=Portfolio.where(user_name: params[:id] )
    	portfolios.each do |portfolio|
    		current_portfolio={}
    		current_portfolio['id']=portfolio['id']
    		investments=Investment.where(portfolio_id: portfolio['id'])
		    investments_status=[]
			investments.each do |investment|
				asset=Asset.find(investment['asset_id'])
				price=asset.price
				current_investment={}
				current_investment['invested_money']=investment['money']
				current_investment['asset_id']=investment['asset_id']
				current_investment['current_money']=investment['stocks']*price
				investments_status.push(current_investment)
			end	
            current_portfolio['investments']=investments_status
            portfolios_status.push(current_portfolio)
    	end
    	render json: {message: 'Portfolios status', name: params[:id],
    		portfolios_status: portfolios_status},status: :ok	
    end	

	private

	def portfolio_params
		params.permit(:user_name)
	end	

end
