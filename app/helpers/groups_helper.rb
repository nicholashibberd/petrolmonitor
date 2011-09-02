module GroupsHelper
  def history_item_summary(group, history_item)
    #history_item['summary_type'] == 'journey' ? journey_history_item(history_item) : payment_history_item(history_item)
    summary_type = history_item['summary_type']
    summary = summary_type == 'journey' ? journey_history_item(history_item) : payment_history_item(history_item)
    content = Builder::XmlMarkup.new
    content.div("class" => "#{summary_type}_history_item history_item") do
      content.div("class" => "history_item_icon #{summary_type}_history_item_icon history_item_field") do
         content.img(:src => "/images/#{summary_type}_icon.gif")
       end
       content.div date_display(history_item['date'], :short), :class => 'history_item_field history_item_date'
      content.div summary, :class => 'history_item_content'
      content.div("class" => 'history_item_edit_link') do
        content.a('Edit', :href => "/groups/#{group.id}/#{summary_type}s/#{history_item['id']}/edit")
      end 
    end
  end
  
  def payment_history_item(history_item)
    "#{display_price(BigDecimal(history_item['amount']))} filled up by #{history_item['contributors']}"
  end

  def journey_history_item(history_item)
    if history_item['complete'] == true
      "#{history_item['miles']} miles travelled by #{history_item["travellers"]} (#{history_item["description"]})"
    else
      "Incomplete journey by #{history_item["travellers"]}" + " (#{history_item["description"]})" if history_item['description']
    end
  end
  
  def date_display(date, format)
    l date, :format => format
  end
end
