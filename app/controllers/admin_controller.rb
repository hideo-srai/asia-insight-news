module Admin; end

class AdminController < ApplicationController
  before_action :authenticate_admin_user! if Rails.env.production?
  before_action :set_preview_post_mode, :calculate_signed_in_users

  layout 'admin'

  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end


  protected

  def calculate_signed_in_users
    user_ids = Rails.cache.read(:signed_in_users_ids) || []
    current_user_id = current_user.try(:id)
    user_ids.push(current_user_id) unless user_ids.include?(current_user_id)
    Rails.cache.write :signed_in_users_ids, user_ids, expires_in: 15.minutes

    @signed_is_users_count = user_ids.count
  end

  def set_preview_post_mode
    session[:post_preview_id] = nil
  end

  def paginate_params
    { page: params[:page], per_page: params[:per_page] }
  end
end