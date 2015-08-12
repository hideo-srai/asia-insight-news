class Admin::ChartsController < AdminController
  def show
    @chart = Chart.first
  end

  def update
    @chart = Chart.first

    if @chart.update_attributes(chart_params)
      flash[:success] = 'Chart was successfully updated'
      redirect_to admin_chart_path
    else
      flash[:error] = 'Please check out the author updating errors'
      render 'show'
    end
  end

  protected

  def chart_params
    params.require(:chart).permit(:image, :description)
  end
end