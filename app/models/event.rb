# frozen_string_literal: true

class Event < ApplicationRecord
  has_and_belongs_to_many :users

  def fill_category
    case :activiy
    when "Career Video" || "Workplace Tour" || "Interview a Professional"
      category = ["career awareness"]
    when "Online Career Exploration" || "Reverse Job Shadow" || "Guest Speaker Career Awareness" || "Workplace Experiential Visit" || "College Visit with Pathway Component"
      category = ["career exploration"]
    when "College & Career Plan"
      category = ["career Awareness", "career Exploration", "career Preparation"]
    else
      category = ["career preparation"]
    end
  end

end
