module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
      when "success"
        "success"
      when "error"
        "danger"
      when "alert"
        "warning"
      when "notice"
        "info"
      else
        flash_type.to_s
    end
  end

  def neighborhoodscout
    if current_user
      partner_name = 'bristol'
      partner_key = '0b7b2ad7856464307c307ba494396a5e'
      email = current_user.email
      today = Time.now.strftime("%Y-%m-%d")
      cleartext = "#{today} #{email} #{partner_key}"
      fingerprint = Digest::MD5.hexdigest(cleartext)
      @url = 'http://www.neighborhoodscout.com/auth?user='+ email + '&fingerprint=' + fingerprint + '&partner_name='+ partner_name
      # @no_post = true
    else
      # @no_post = false
      @url = 'http://neighborhoodscout.com'
    end
  end

end
