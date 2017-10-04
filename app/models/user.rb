# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :events

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def name
    first_name+" "+last_name
  end

  after_save :make_school_provider


  private
  def make_school_provider
    if !Provider.exists?( organization: school ) && school
      Provider.create( organization: school,
                       location: school,
                       url: "N/A"
                      )
    end
  end
end
