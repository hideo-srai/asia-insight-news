class ApplicationMailer < ActionMailer::Base
  default :from => 'MNI Asia Insight Notifications <notifications@mni-news.com>'

  def new_subscriber_email(subscriber)
    @subscriber = subscriber
    mail(to: Mni::Application.config.new_subscribers_email,
         subject:  'MNI Asia Insight / New Subscriber')
  end

  def daily_new_subscribers_list(csv_content)
    formatted_date = Time.zone.now.strftime('%Y-%m-%d')
    attachments["MNI-Asia-Insight-New-subsсribers-#{formatted_date}.csv"] = {
      mime_type: 'text/csv',
      content: csv_content
    }
    mail to: Mni::Application.config.new_subscribers_notification_email_list,
         subject: 'MNI Asia Insigh / New Subscriber for yesterday'
  end
end
