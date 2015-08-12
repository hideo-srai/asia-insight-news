class Admin::CentralBanksController < AdminController
  def index
    @central_banks = CentralBank.paginate(paginate_params)
  end

  def new
    @central_bank = CentralBank.new
  end

  def create
    @central_bank = CentralBank.new(central_bank_params)

    if @central_bank.save
      flash[:success] = 'Central bank was successfully created'

      redirect_to admin_central_banks_path
    else
      flash[:error] = "Can't create a central bank. Checkout the errors below"
      render 'new'
    end
  end

  def edit
    @central_bank = CentralBank.find(params[:id])
  end

  def update
    @central_bank = CentralBank.find(params[:id])

    if @central_bank.update_attributes(central_bank_params)
      flash[:success] = 'Central bank was successfully updated'

      redirect_to admin_central_banks_path
    else
      flash[:error] = 'Please checkout the central bank updating errors'
      render 'edit'
    end
  end

  def destroy
    @central_bank = CentralBank.find(params[:id])
    @central_bank.destroy if @central_bank.present?

    redirect_to admin_central_banks_path, flash: { success: 'Central bank was successfully destroyed' }
  end

  protected

  def central_bank_params
    params.require(:central_bank).permit(:name, :bank_name, :bank_link, :policy_target, :current_settings, :change,
                                         :next_policy_announcement, :report_name, :report_link,
                                         :change_expected, :changed_at, :in_ticker)
  end
end