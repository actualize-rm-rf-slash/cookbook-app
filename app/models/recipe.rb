class Recipe < ApplicationRecord
  belongs_to :user, optional: true

  def ingredients_list
    ingredients.split(", ")
  end

  def directions_list
    directions.split(", ")
  end

  def friendly_created_at
    created_at.strftime("%B %e, %Y")
  end

  def friendly_prep_time
    hours = prep_time / 60
    minutes = prep_time % 60
    result = ""
    result += "#{hours} hours " if hours > 0
    result += "#{minutes} minutes" if minutes > 0
    result
  end

  def as_json
    {
      id: id,
      title: title,
      chef: chef,
      image: image_url,
      ingredients: ingredients_list,
      directions: directions_list,
      created_at: friendly_created_at,
      prep_time: friendly_prep_time
    }
  end
end
