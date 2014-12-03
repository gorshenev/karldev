class Speciality < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :events, :dependent => :nullify

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
