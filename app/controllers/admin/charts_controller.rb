class Admin::ChartsController < AdminController
  before_action :set_chart, only: [:show, :edit, :update, :destroy]

  def index
    @charts = Chart.all.paginate(paginate_params)
  end

  def new
    @chart = Chart.new
  end

  def edit
  end

  def create
    @chart = Chart.new(chart_params)
    if @chart.save
      flash[:success] = 'Chart was successfully created'
      redirect_to admin_charts_path
    else
      flash[:error] = 'Please check out the author creating errors'
      render 'new'
    end
  end

  def update
    if @chart.update(chart_params)
      flash[:success] = 'Chart was successfully updated'
      redirect_to admin_charts_path
    else
      flash[:error] = 'Please check out the author updating errors'
      render 'edit'
    end
  end

  protected

  def set_chart
    @chart = Chart.find(params[:id])
  end

  def chart_params
    params.require(:chart).permit(:image, :description)
  end
end
