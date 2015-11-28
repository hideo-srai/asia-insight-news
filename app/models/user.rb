class User < ActiveRecord::Base
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
