class Oven < ActiveRecord::Base
  belongs_to :user
  has_many :cookies, as: :storage

  validates :user, presence: true

  def set_timer
    self.timer = Time.now + 2.minutes
  end

  def ready?
    !timer.nil? && timer <= Time.now
  end

  def build_cookies
    Cookie.new(storage: self)
  end

  def bake_cookies(cookie)
    cookie[:amount].to_i.times do
      self.cookies << Cookie.new(fillings: cookie[:fillings])
    end
    set_timer
    save!
  end

  def empty(user)
    if !timer.nil? && cookies.count > 0 && timer <= Time.now
      # TODO: This can be updated in one DB call.
      cookies.each do |cookie|
        cookie.update_attributes!(storage: user)
      end
      timer = nil
      save!
    else
      false
    end
  end

  private :set_timer
end
