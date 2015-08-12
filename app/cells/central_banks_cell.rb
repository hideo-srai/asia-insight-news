class CentralBanksCell < FrontendCell
  def sidebar
    @banks = CentralBank.latest.limit(4)

    if @banks.any?
      render
    else
      render nothing: true
    end
  end
end
