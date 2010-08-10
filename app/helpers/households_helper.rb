module HouseholdsHelper
  def get_mobile_phones(guardians)
    if guardians.size == 1
      return "<strong>Mobile Phone:</strong> #{number_to_phone(h(guardians[0].mobile_phone))}"
    else
      str = ""
      for g in guardians
        str += "<strong>Mobile Phone:</strong> #{number_to_phone(h(g.mobile_phone))} (#{h(g.first_name)})<br />"
      end
      return str
    end
  end

  def get_work_phones(guardians)
    if guardians.size == 1
      return "<strong>Work Phone:</strong> #{number_to_phone(h(guardians[0].work_phone))}"
    else
      str = ""
      for g in guardians
        str += "<strong>Work Phone:</strong> #{number_to_phone(h(g.work_phone))} (#{h(g.first_name)})<br />"
      end
      return str
    end
  end
  
  def get_emails(guardians)
    if guardians.size == 1
      return "<strong>Email:</strong> #{h(guardians.first.user.email)}"
    else
      str = ""
      for g in guardians
        str += "<strong>Email:</strong> #{h(g.user.email)} (#{h(g.first_name)})<br />"
      end
      return str
    end
  end
end
