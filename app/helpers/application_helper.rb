module ApplicationHelper
  def user_status(user)
    if user
      content_tag(:div, (link_to "#{current_user.name}: Sign out", signout_path), :id => 'signout_link')
    else
      content_tag(:div, (link_to "Sign in", signin_path), :id => 'signout_link')
    end
  end
  
  def display_journey_cost(amount)
    if amount.is_a?(BigDecimal)  
      amount = amount / BigDecimal("100")
      number_to_currency amount, :unit => '£', :separator => ".", :delimiter => ","
    else
      amount
    end
  end

  def display_price(amount)
      amount = amount / BigDecimal("100")
      number_to_currency amount, :unit => '£', :separator => ".", :delimiter => ","
  end
  
  def display_price_for_form(amount)
    if amount
      new_value = BigDecimal("#{amount}") / BigDecimal("100")
      number_to_currency new_value, :unit => '', :separator => ".", :delimiter => ","
    end
  end
  
  def top_nav_link(link_text, link)
    if request.path == link 
      link_to link_text, link, :class => 'selected'
    else
      link_to link_text, link
    end
  end
  
  def markaby(&block)
    Markaby::Builder.new({}, self, &block)
  end
  
end
