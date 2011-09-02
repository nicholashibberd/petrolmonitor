module UsersHelper
  def set_user_cookie(user)
    user.remember_me!
    cookies[:remember_token] = {:value => user.remember_token, :expires => 20.years.from_now.utc}
    self.current_user = user
  end
  
  def current_user=(user)
   @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def user_from_remember_token
    remember_token = cookies[:remember_token]
    User.find_by_remember_token(remember_token) unless remember_token.nil?
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def group_links(user, &block)
    unless user.group
      content_tag(:div, nil, &block)
    end
  end  

  def group_info(user, &block)
    if user.group
      content_tag(:div, nil, &block)
    end
  end  
  
  def balance_for_user(user)
    user_is_current_user = (user.id == current_user.id)
    balance = user.balance
    if balance > 0
      summary = user_is_current_user ? "I am owed #{display_price(balance)}" : "#{user.name} is owed #{display_price(balance)}"
      content_tag(:div, summary, :class => 'user_summary owed')
    elsif balance < 0
      summary = user_is_current_user ? "I owe #{display_price(balance)}" : "#{user.name} owes #{display_price(balance)}"
      content_tag(:div, summary, :class => 'user_summary owes')
    else
      summary = user_is_current_user ? "I am square" : "#{user.name} is square"
      content_tag(:div, summary, :class => 'user_summary square')
    end
  end

  def summary_for_user(user)
    user_is_current_user = (user.id == current_user.id)
    balance = user.balance

    user_have = user_is_current_user ? "I have" : "#{user.name} has"
    user_am = user_is_current_user ? "I am" : "#{user.name} is"
    user_owes = user_is_current_user ? "I owe" : "#{user.name} owes"
    detail = "#{user_have} used #{display_price(user.total_liability)} and contributed #{display_price(user.total_contribution)} worth of petrol"

    if balance > 0
      xmlmarkup("#{user_am} owed #{display_price(balance)}", detail, 'owed')
    elsif balance < 0
      xmlmarkup("#{user_owes} #{display_price(balance.abs)}", detail, 'owes')
    else
      xmlmarkup("#{user_have} no outstanding balance", detail, 'square')
    end
  end
  
  def xmlmarkup(summary, detail, status)
    xml = Builder::XmlMarkup.new
    xml.div("class" => "user_summary") do
      xml.div summary, :class => "user_balance #{status}"
      xml.div detail, :class => 'user_detail'
    end
  end
  
end
