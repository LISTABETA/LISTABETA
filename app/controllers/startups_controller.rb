class StartupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  autocomplete :startup, :markets

  def index
    if params[:search].present?
      @startups = Startup.order_by_publication
                         .by_title(params[:search])
                         .page(params[:page]).per(32)
    else
      @startups = Startup.order_by_publication
                         .page(params[:page]).per(32)
    end
  end

  def show
    authorize @startup = Startup.friendly.find(params[:id])
  end

  def new
    @startup = current_user.startups.new
  end

  def create
    authorize @startup = current_user.startups.new(permitted_params)

    if @startup.valid?
      @startup.save
      flash[:notice] = 'Sua Startup enviada e em breve será avaliada!'
      redirect_to dashboard_path
    else
      flash[:alert] = 'Por favor, confira os erros'
      render :new
    end
  end

  def destroy
    authorize @startup = current_user.startups.friendly.find(params[:id])

    if @startup.destroy
      flash[:notice] = 'Sua Startup foi removida com sucesso'
    else
      flash[:alert] = 'Houve um erro ao remover sua Startup'
    end

    redirect_to dashboard_path
  end

  def autocomplete_startup_markets
    markets = Tag.search(params[:term]).order(:name)
    render json: markets.map { |market| { label: market.name, value: market.name } }
  end

  private

  def permitted_params
    params.require(:startup).permit([:email, :name, :website, :screenshot, :screenshot_cache,
                                     :pitch, :description, :phase, :state, :city, :market_list,
                                     :slug, :demonstration])
  end
end
