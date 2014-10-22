module EventCalendar
  module ClassMethods
    
    def events_for_date_range(start_d, end_d, find_options = {})
      self.where(find_options).where([ "(? <= #{self.end_at_field}  OR #{self.end_at_field} is null) AND (#{self.start_at_field}< ?)", start_d.to_time.utc, end_d.to_time.utc ]).
        order("#{self.start_at_field} ASC")
      
    end

    def create_event_strips(strip_start, strip_end, events)
      # create an inital event strip, with a nil entry for every day of the displayed days
      event_strips = [[nil] * (strip_end - strip_start + 1)]
  
      events.each do |event|
        cur_date = event.start_at.to_date
        end_date = event.end_at.nil? ? event.start_at.to_date : event.end_at.to_date
        cur_date, end_date = event.clip_range(strip_start, strip_end)
        start_range = (cur_date - strip_start).to_i
        end_range = (end_date - strip_start).to_i
    
        # make sure the event is within our viewing range
        if (start_range <= end_range) and (end_range >= 0) 
          range = start_range..end_range
        
          open_strip = space_in_current_strips?(event_strips, range)
        
          if open_strip.nil?
            # no strips open, make a new one
            new_strip = [nil] * (strip_end - strip_start + 1)
            range.each {|r| new_strip[r] = event}
            event_strips << new_strip
          else
            # found an open strip, add this event to it
            range.each {|r| open_strip[r] = event}
          end
        end
      end
      event_strips
    end
  end
  
  module InstanceMethods
    def days
       end_at.nil? ? start_date : end_at.to_date - start_at.to_date
     end
     
    def clip_range(start_d, end_d)
      # make sure we are comparing date objects to date objects,
      # otherwise timezones can cause problems
      start_at_d = start_at.to_date
      end_at_d = end_at.nil? ? start_at.to_date : end_at.to_date
      # Clip start date, make sure it also ends on or after the start range
      if (start_at_d < start_d and end_at_d >= start_d)
        clipped_start = start_d
      else
        clipped_start = start_at_d
      end
    
      # Clip end date
      if (end_at_d > end_d)
        clipped_end = end_d
      else
        clipped_end = end_at_d
      end
      [clipped_start, clipped_end]
    end
    
  end
  
end