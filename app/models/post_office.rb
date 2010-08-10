class PostOffice < ActionMailer::Base
  
  #include ActionController::UrlWriter
  default_url_options[:host] = "localhost:3000"
  
  def profile_added(recipient, sent_at = Time.now)
    subject    'New Account Online with PUCS'
    recipients recipient.user.email
    from       'admin@pucs.org'
    sent_on    sent_at
    body       :recipient => recipient
  end
  
  def password_reset_instructions(user, sent_at = Time.now)
    subject    'Instructions for resetting your password at pucs-families.org'
    recipients user.email
    from       'admin@pucs.org'
    sent_on    sent_at
    body       :edit_password_reset_url => "http://localhost:3000/" #edit_password_reset_url(user.perishable_token)
    #body       :edit_password_resets_url => edit_password_resets_url(user.perishable_token)
  end

  # def announcement(sent_at = Time.now)
  #   subject    'PostOffice#announcement'
  #   recipients ''
  #   from       'admin@pucs.org'
  #   sent_on    sent_at
  #   
  #   body       :greeting => 'Hi,'
  # end

  # def profile_revised(sent_at = Time.now)
  #   subject    'PostOffice#profile_revised'
  #   recipients ''
  #   from       'profh@cmu.edu'
  #   sent_on    sent_at
  #   
  #   body       :greeting => 'Hi,'
  # end

end
