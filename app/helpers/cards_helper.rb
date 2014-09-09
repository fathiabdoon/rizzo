module CardsHelper

  def card_classes(props)
    [
      "card",
      "js-card",
      "card--#{props[:kind]}",
      "card--#{props[:short?] ? 'short' : 'tall'}",
      "card--#{props[:fixed?] ? 'fixed' : 'flexible'}",
      "card--#{props[:cover?] ? 'cover' : 'standard'}",
      "card--#{props[:double?] ? 'double' : 'single'}",
      "card--#{props[:tags] && !props[:tags].empty? ? 'has-tags' : 'no-tags'}",
      "card--#{props[:image_url] && !props[:image_url].empty? ? 'has-img' : 'no-img'}",
      "card--#{props[:button_text] || props[:author_name] || props[:post_date] ? 'has-footer' : 'no-footer'}"
    ]
  end

  def card_link_data(props)
    card_tracking_data(props).merge(card_layer_data(props))
  end

  def card_tracking_data(props)
    return {} unless props[:tracking] && !props[:tracking].empty?
    HashWithIndifferentAccess.new(
      lpa_category: props[:tracking][:category],
      lpa_action: props[:tracking][:action],
      lpa_label: props[:tracking][:label]
    )
  end

  def card_layer_data(props)
    return {} unless props[:layer?]
    {
      lightbox: {
        showPreloader: true,
        class: 'lightbox--layer'
      }
    }
  end

  def card_icon(props)
    case props[:kind]
    when 'need-to-know'
      return 'information'
    end

    props[:kind]
  end

  def card_link_if(condition, *props)
    if condition
      haml_tag(:a, *props){ yield }
    else
      yield
    end
  end

  def card_datetime(date_str)
    date_str.to_date.strftime("%d %B %Y")
  end

end
