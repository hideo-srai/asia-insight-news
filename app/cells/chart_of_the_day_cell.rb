class ChartOfTheDayCell < FrontendCell
  def sidebar
    @chart = Chart.last

    if @chart.present? && @chart.description.present?
      render
    else
      render nothing: true
    end
  end
end
