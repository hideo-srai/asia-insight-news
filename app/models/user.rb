class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable #:registerable, :recoverable,
  #:ldap_authenticatable,

  devise :cas_authenticatable

  validates :name, length: { maximum: 255 }
  validates :username, presence: true

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
