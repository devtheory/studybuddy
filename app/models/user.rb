class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, :through => :memberships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  def isAdminFor(group)
    hasMembership = current_user.memberships.where(group_id: group.id).first
    if hasMembership.nil?
      false
    else
      hasMembership.role == "admin"
    end
  end

  def isMember(group)
    hasMembership = current_user.memberships.where(group_id: group.id).first
    if hasMembership.nil?
      false
    else
      hasMembership.role == "none"
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.avatar = auth.info.image
      user.location = auth.info.location
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
