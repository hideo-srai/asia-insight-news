class FrontendCell < Cell::Rails
  include Devise::Controllers::Helpers

  protected

  def apply_posts_scope(scope)
    scope.published #current_user ? scope : scope.outdated
  end
end