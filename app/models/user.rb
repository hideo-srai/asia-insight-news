class User < ActiveRecord::Base
  has_one :user_setting, dependent: :destroy
  accepts_nested_attributes_for :user_setting

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable #:registerable, :recoverable,
  #:ldap_authenticatable,

  devise :cas_authenticatable

  validates :name, length: { maximum: 255 }
  validates :username, presence: true

  enum user_group: { subscriber: 'subscriber',
                     trialist: 'trialist',
                     trial_registrant: 'trial_registrant',
                     email_registrant: 'email_registrant',
                     test: 'test' }

  def self.find_all_to_notify(user_groups)
    self.joins('INNER JOIN user_settings ON (user_settings.user_id = users.id AND (user_settings.email_alerts=true OR user_settings.email_alerts is NULL))')
        .where(user_group: user_groups)
  end

   def user_group=(value)
     self.user_group_changed_at = Time.zone.now
     self.previous_user_group = self.user_group_was
     super(value)
   end

  def cas_extra_attributes=(extra_attributes)
    extra_attributes.each do |name, value|
      case name.to_sym
        when :fullname
          self.fullname = value
        when :email
          self.email = value
      end
    end
  end
end
