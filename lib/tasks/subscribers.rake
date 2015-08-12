
namespace :subscribers do
  desc 'Send new subscribers to marketing managers in CSV'
  task :update_with_latest => :environment do
    notifier = NewSubscribersEmailNotifier.new
    notifier.notify
  end
end