# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def string_not_empty(string)
    return false if !string or string.empty?
    return true
  end

  def format_time(time)
    if time
      now = Time.now 
      secs_duration = now-time
      mins_duration = secs_duration / 60
      hours_duration = mins_duration / 60
      days_duration = hours_duration / 24
      if days_duration < 1
        return "#{time_ago_in_words(time)} ago"
      else
        return time.ctime
      end
      
    end
  end
  
end
