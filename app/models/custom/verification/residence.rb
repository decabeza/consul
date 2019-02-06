require_dependency Rails.root.join("app", "models", "verification", "residence").to_s

class Verification::Residence
  clear_validators!

  validates :date_of_birth, presence: true
  validates :terms_of_service, acceptance: { allow_nil: false }
  validates :postal_code, presence: true

  validate :allowed_age
  validate :postal_code_is_allowed
  validate :document_number_uniqueness_if_present

  def geozone
    nil
  end

  def gender
    nil
  end

  alias_method :default_save, :save

  def save
    default_save && user.update(verified_at: Time.current)
  end

  private

    def retrieve_census_data
      # Empty method because we don't check against census
    end

    def postal_code_is_allowed
      errors.add(:postal_code, I18n.t("verification.residence.new.error_not_allowed_postal_code")) unless valid_postal_code?
    end

    def valid_postal_code?
      Zipcode.pluck(:code).include?(postal_code.upcase)
    end

    def document_number_uniqueness_if_present
      if document_number.present?
        document_number_uniqueness
      end
    end
end