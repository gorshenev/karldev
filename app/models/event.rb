class Event < ActiveRecord::Base
  filterrific :default_settings => {sorted_by: 'created_at_desc'},
              :filter_names => %w[
                sorted_by
                search_query
                with_speciality_id
                with_created_at_gte
              ]

  # default for will_paginate
  self.per_page = 10

  belongs_to :speciality

  belongs_to :creator, :class_name => "User"
  belongs_to :specialities, :class_name => "User"
  has_many :users, :foreign_key => :speciality_id

  has_many :invites, :foreign_key => "attended_event_id"
  has_many :attendees, :through => :invites

  scope :upcoming, -> { where("Date >= ?", Date.today).order('Date ASC') }
  scope :past, -> { where("Date < ?", Date.today).order('Date DESC') }
  scope :specialities, -> {Event.where('title = "Событие декабрь" OR location = "Москва"')}


  scope :between, lambda {|start_time, end_time|
                  {conditions: ["? < starts_at < ?", Event.format_date(start_time), Event.format_date(end_time)]}
                }



  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
        :id => self.id,
        :title => self.title,
        :description => self.description || "",
        :start => starts_at.rfc822,
        :end => ends_at.rfc822,
        :allDay => self.all_day,
        :recurring => false,
        :url => Rails.application.routes.url_helpers.event_path(id),
        :color => self.color,
        :location => self.location

    }

  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  scope :search_query, lambda { |query|
                       return nil  if query.blank?
                       # condition query, parse into individual keywords
                       terms = query.downcase.split(/\s+/)
                       # replace "*" with "%" for wildcard searches,
                       # append '%', remove duplicate '%'s
                       terms = terms.map { |e|
                         (e.gsub('*', '%') + '%').gsub(/%+/, '%')
                       }
                       # configure number of OR conditions for provision
                       # of interpolation arguments. Adjust this if you
                       # change the number of OR conditions.
                       num_or_conditions = 3
                       where(
                           terms.map {
                             or_clauses = [
                                 "LOWER(events.speciality_id) LIKE ?",
                                 "LOWER(events.location) LIKE ?",
                                 "LOWER(events.title) LIKE ?"
                             ].join(' OR ')
                             "(#{ or_clauses })"
                           }.join(' AND '),
                           *terms.map { |e| [e] * num_or_conditions }.flatten
                       )
                     }

  scope :sorted_by, lambda { |sort_option|
                    # extract the sort direction from the param value.
                    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
                    case sort_option.to_s
                      when /^created_at_/
                        order("events.created_at #{ direction }")
                      when /^speciality_id_/
                        order("LOWER(events.speciality_id) #{ direction }, LOWER(events.color) #{ direction }")
                      when /^speciality_name_/
                        order("LOWER(speciality.name) #{ direction }").includes(:speciality)
                      else
                        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
                    end
                  }
  scope :with_speciality_id, lambda { |speciality_ids|
                          where(:speciality_id => [*speciality_ids])
                        }
  scope :with_created_at_gte, lambda { |ref_date|
                              where('events.created_at >= ?', ref_date)
                            }

  delegate :name, :to => :speciality, :prefix => true

  def self.options_for_sorted_by
    [
        ['Name (a-z)', 'name_asc'],
        ['Registration date (newest first)', 'created_at_desc'],
        ['Registration date (oldest first)', 'created_at_asc'],
        ['Speciality (a-z)', 'speciality_name_asc']
    ]
  end



  def decorated_created_at
    created_at.to_date.to_s(:long)
  end


end
