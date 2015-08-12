require 'csv'

class NewSubscribersEmailNotifier
  def initialize(date_from=1.day.ago)
    @date_from = date_from
  end

  def notify
    subscribers = Subscriber.where('created_at > ?', @date_from)

    if subscribers.count > 0
      csv_content = prepare_csv(subscribers)

      ApplicationMailer.daily_new_subscribers_list(csv_content).deliver
      puts 'NewSubscribersEmailNotifier#Success: Marketing managers were successfully notified about new subscribers'
    else
      puts 'NewSubscribersEmailNotifier#Empty: There were no new subscribers to notify about'
    end
  end


  protected

  def prepare_csv(subscribers)
    CSV.generate do |csv|
      csv << ['Title', 'First name', 'Last name', 'E-mail', 'Company name', 'Telephone number']
      subscribers.each do |s|
        csv << [s.title, s.first_name, s.last_name, s.email, s.company, s.phone_number]
      end
    end
  end
end