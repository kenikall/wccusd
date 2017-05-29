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
end
