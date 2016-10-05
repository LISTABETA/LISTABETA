class StartupsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  autocomplete :startup, :markets,

  def index
    if params[:q].present?
      @startups = Startup.approved
                         .order_by_approvement
                         .by_title(params[:q])
                         .page(params[:page]).per(20)
    else
      @startups = Startup.approved
                         .order_by_approvement
                         .page(params[:page]).per(20)
    end
  end

  def show
    @startup = Startup.friendly.find(params[:id])
  end

  def new
    @startup = current_user.startups.new
  end

  def create
    @startup = current_user.startups.new(permitted_params)

    if @startup.valid?
      @startup.save
      flash[:notice] = 'Sua Startup foi registrada. Confira as informações antes de submete-la!'
      redirect_to dashboard_path
    else
      flash[:alert] = 'Por favor, confira os erros'
      render :new
    end
  end

  def edit
    @startup = current_user.startups.friendly.find(params[:id])
  end

  def update
    @startup = current_user.startups.friendly.find(params[:id])

    if @startup.update(permitted_params)
      flash[:notice] = 'As informações da sua Startup foram atualizadas!'
      redirect_to dashboard_path
    else
      flash[:alert] = 'Por favor, confira os erros'
      render :edit
    end
  end

  def submit
    @startup = current_user.startups.friendly.find(params[:startup_id])

    if @startup.submit!
      flash[:notice] = 'Sua Startup foi submetida a aprovação!'
    else
      flash[:alert] = 'Houve um erro ao submeter sua Startup'
    end

    redirect_to dashboard_path
  end

  def destroy
    @startup = current_user.startups.friendly.find(params[:id])

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
                                     :pitch, :description, :phase, :state, :city, :market_list])
  end
end
