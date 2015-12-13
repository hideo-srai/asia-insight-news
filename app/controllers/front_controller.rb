class FrontController < ApplicationController
  before_action :prepare_new_subscriber, :fetch_search_filter, :prepare_common_js_data
  before_action :check_sso_registration_params
  before_action :set_cookies

  layout 'front'
  #before_action :authenticate_user!

  def prepare_new_subscriber
    @subscriber = Subscriber.new
    @new_user = User.new(user_group: 'trial_registrant')
  end

  protected

  def prepare_common_js_data
    gon.userLoggedIn = current_user.present?
  end

  def fetch_search_filter
    @search_filter = OpenStruct.new(params[:search_filter])
  end

  def apply_posts_scope(scope)
    scope.published #current_user ? scope : scope.outdated
  end

  def prepare_ticker_data
    posts = apply_posts_scope(Post.all).in_ticker.latest.limit(10)
    events = Event.in_ticker.upcoming.limit(10)
    cbs = CentralBank.in_ticker.latest.limit(3)
    links = Link.in_ticker.latest.limit(5)

    now = Time.zone.now
    items = [
      posts.map   { |post|  { title: post.headline, date: post.published_at, url: post_path(post.id) } },
      events.map  { |event| { title: event.title, date: event.date.to_time, url: events_path } },
      links.map   { |link|  { title: link.title, date: link.published_at, url: link.url } },
      cbs.map     { |cb|    { title: "#{cb.bank_name} #{cb.report_name}", date: cb.created_at, url: central_banks_path } },
    ]

    @ticker_items = items.flatten.sort_by { |item| now - item[:date] }
  end

  def check_sso_registration_params
    sso_u = params[:sso_u]
    sso_a = params[:sso_a]

    if sso_u.present? && sso_a.present?
      redirect_to new_user_session_path(sso_u: sso_u, sso_a: sso_a)
    end
  end

  def set_cookies
    CookiesWriter.new(cookies, current_user).set_cookies
  end
end
