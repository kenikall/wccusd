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

  def self.create_teacher(new_teacher_info)
    user = User.new( email: new_teacher_info[:email],
                     password: "change_this_imediately",
                     school: new_teacher_info[:school],
                     pathway: new_teacher_info[:pathway],
                    )
    useradd_role(:teacher)
    user.save
  end

  def self.create_admin(new_admin_info)
    user = User.new( email: new_admin_info[:email],
                     password: "change_this_imediately",
                     school: new_admin_info[:school],
                     pathway: new_admin_info[:pathway],
                    )
    useradd_role(:teacher)
    user.save
  end
  after_save :make_school_provider


  private
  def make_school_provider
    if !Provider.exists?( name: school ) && school
      Provider.create( name: school,
                       location: school,
                       url: "N/A"
                      )
    end
  end
end
