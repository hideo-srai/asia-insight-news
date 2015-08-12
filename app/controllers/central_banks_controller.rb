class CentralBanksController < FrontController
  def index
    @central_banks = CentralBank.latest
  end
end