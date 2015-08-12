class Admin::CountriesController < AdminController
  def index
    @countries = Country.all
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)

    if @country.save
      flash[:success] = 'Country was successfully created'

      redirect_to admin_countries_path
    else
      flash[:error] = "Can't create a country. Checkout the errors below"
      render 'new'
    end
  end

  def edit
    @country = Country.find(params[:id])
  end

  def update
    @country = Country.find(params[:id])

    if @country.update_attributes(country_params)
      flash[:success] = 'Country was successfully updated'

      redirect_to admin_countries_path
    else
      flash[:error] = 'Please checkout the country updating errors'
      render 'edit'
    end
  end

  def destroy
    @country = Country.find(params[:id])
    @country.destroy if @country.present?

    redirect_to admin_countrys_path, flash: { success: 'Country was successfully destroyed' }
  end

  protected

  def country_params
    params.require(:country).permit(:name)
  end
end