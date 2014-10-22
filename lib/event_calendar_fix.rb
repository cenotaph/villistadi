module EventCalendar
  module ClassMethods
    def events_for_date_range(start_d, end_d, find_options = {})
      self.where(find_options).where([ "(? <= #{self.end_at_field}) AND (#{self.start_at_field}< ?)", start_d.to_time.utc, end_d.to_time.utc ]).
        order("#{self.start_at_field} ASC")
      
    end
  end
end