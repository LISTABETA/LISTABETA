ActiveAdmin.register Startup do
  scope 'Pendente' do |startups|
    startups.where(status: Status::PENDING)
  end

  scope 'Aprovadas' do |startups|
    startups.where(status: Status::APPROVED)
  end

  scope 'Desaprovadas' do |startups|
    startups.where(status: Status::UNAPPROVED)
  end

  scope 'Publicadas' do |startups|
    startups.where(status: Status::PUBLISHED)
  end

  controller do
    private

    def permitted_params
      params.permit(startup: [:email, :name, :website, :pitch, :description,
                              :screenshot, :status, :state, :city, :market_list,
                              :approved_at, :highlighted_at, :slug, :published_at])
    end

    def resource
      @startup ||= Startup.friendly.find(params[:id])
    end
  end
  # Actions to highlight Startup
  member_action :highlight do
    startup = Startup.friendly.find(params[:id])
    if startup.highlight!
      flash[:notice] = "Startup posta em destaque com sucesso."
    else
      flash[:alert] = startup.errors.full_messages.first
    end
    redirect_to :back
  end

  member_action :unhighlight do
    startup = Startup.friendly.find(params[:id])
    if startup.unhighlight!
      flash[:notice] = "Startup tirada de destaque com sucesso."
    else
      flash[:alert] = startup.errors.full_messages.first
    end
    redirect_to :back
  end

  # Actions to approve Startup
  member_action :approve do
    startup = Startup.friendly.find(params[:id])
    if startup.approve!
      flash[:notice] = "Startup aprovada com sucesso."
    else
      flash[:alert] = startup.errors.full_messages.first
    end
    redirect_to :back
  end

  member_action :unapprove do
    startup = Startup.friendly.find(params[:id])
    if startup.unapprove!
      flash[:notice] = "Startup desaprovada com sucesso."
    else
      flash[:alert] = startup.errors.full_messages.first
    end
    redirect_to :back
  end

  member_action :publish do
    startup = Startup.friendly.find(params[:id])
    if startup.publish!
      flash[:notice] = "Startup publicada com sucesso."
    else
      flash[:alert] = startup.errors.full_messages.first
    end
    redirect_to :back
  end

  action_item only: :show do
    startup = Startup.friendly.find(params[:id])
    link_to "Aprovar", approve_admin_startup_path if startup.unapproved? || startup.pending?
  end

  action_item only: :show do
    startup = Startup.friendly.find(params[:id])
    link_to "Desaprovar", unapprove_admin_startup_path if startup.approved? || startup.pending?
  end

  action_item only: :show do
    startup = Startup.friendly.find(params[:id])
    link_to "Publicar", publish_admin_startup_path if startup.approved?
  end

  action_item only: :show do
    startup = Startup.friendly.find(params[:id])
    unless startup.highlighted.nil?
      link_to "Destacar", highlight_admin_startup_path if !startup.highlighted?
    end
  end

  action_item only: :show do
    startup = Startup.friendly.find(params[:id])
    unless startup.highlighted.nil?
      link_to "Tirar do destaque", unhighlight_admin_startup_path if startup.highlighted?
    end
  end

  index do
    selectable_column
    column :id
    column :status do |startup|
      status_tag(Status.t(startup.status))
    end
    column :name
    column :website
    column :email
    actions
  end

  show do
    attributes_table do
      row :status do |startup|
        status_tag(Status.t(startup.status))
      end
      row :screenshot do |startup|
        link_to startup.screenshot, startup.screenshot_url, target: 'blank'
      end
      row :name do |startup|
        link_to startup.name, startup_path(startup)
      end
      row :website do |startup|
        link_to startup.website, startup.website, target: 'blank'
      end
      row :pitch
      row :description
      row :email
      row :twitter do |startup|
        link_to startup.twitter, startup.twitter, target: 'blank'
      end
      row :state
      row :city
      row :markets do |startup|
        startup.market_list.each { |market| puts status_tag(market) }
      end
      row :highlighted do |startup|
        status_tag(startup.highlighted? ? 'Sim' : 'Não')
      end
      row :approved_at
      row :published_at
      row :highlighted_at
    end
  end
end
