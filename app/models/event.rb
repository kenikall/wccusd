# frozen_string_literal: true

class Event < ApplicationRecord
  has_and_belongs_to_many :users

  def category
    case :activiy
    when "Career Video" || "Workplace Tour" || "Interview a Professional"
      return  ["career awareness"]
    when "Online Career Exploration" || "Reverse Job Shadow" || "Guest Speaker Career Awareness" || "Workplace Experiential Visit" || "College Visit with Pathway Component"
      return ["career exploration"]
    when "College & Career Plan"
      return ["career Awareness", "career Exploration", "career Preparation"]
    else
      return ["career preparation"]
    end
  end

end
