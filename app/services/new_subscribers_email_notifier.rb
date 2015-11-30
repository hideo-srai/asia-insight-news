require 'csv'

class NewSubscribersEmailNotifier
  def initialize(date_from=1.day.ago)
    @date_from = date_from
  end

  def notify
    users = User.where('created_at > ?', @date_from)

    if users.count > 0
      csv_content = prepare_csv(users)

      ApplicationMailer.daily_new_subscribers_list(csv_content).deliver
      puts 'NewSubscribersEmailNotifier#Success: Marketing managers were successfully notified about new users'
    else
      puts 'NewSubscribersEmailNotifier#Empty: There were no new users to notify about'
    end
  end


  protected

  def prepare_csv(users)
    CSV.generate do |csv|
      csv << ['Title', 'First name', 'Last name', 'E-mail', 'Company name', 'Telephone number']
      users.each do |user|
        csv << [user.title, user.first_name, user.last_name, user.email, user.company, user.phone_number]
      end
    end
  end
end
