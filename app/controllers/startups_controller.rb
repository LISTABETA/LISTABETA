class StartupsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @startups = Startup.approved.order_by_approvement.page(params[:page]).per(20)
  end

  def new
    @startup = current_user.startups.new
  end

  def create
    @startup = current_user.startups.new

    if @startup.valid?
      @startup.save
      flash[:notice] = 'Sua Startup foi cadastrada e está esperando aprovação'
      redirect_to dashboard_path
    else
      flash[:alert] = 'Por favor, confira os erros'
      render :new
    end
  end

  def edit
    @startup = current_user.startups.find(params[:id])
  end

  def update
    @startup = current_user.startups.find(params[:id])

    if @startup.valid?
      @startup.save
      flash[:notice] = 'Sua Startup foi cadastrada e está esperando aprovação'
      redirect_to dashboard_path
    else
      flash[:alert] = 'Por favor, confira os erros'
      render :edit
    end
  end

  def destroy
    @startup = current_user.startups.find(params[:id])

    if @startup.destroy
      flash[:notice] = 'Sua Startup foi removida com sucesso'
    else
      flash[:alert] = 'Houve um erro ao remover sua Startup'
    end

    redirect_to dashboard_path
  end

  private

  def permitted_params
    params.require(:startup).permit([:email, :name, :website, :screenshot, :screenshot_cache,
                                     :pitch, :description, :phase, :state, :city, :market_list])
  end
end
