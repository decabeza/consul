require_dependency Rails.root.join("app", "models", "user").to_s

class User
  def sms_verified?
    true
  end

  def verification_sms_sent?
    true
  end

  def verification_letter_sent?
    true
  end
end
