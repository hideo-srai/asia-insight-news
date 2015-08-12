class ChartOfTheDayCell < FrontendCell
  def sidebar
    @chart = Chart.first

    if @chart.present? && @chart.description.present?
      render
    else
      render nothing: true
    end
  end
end
