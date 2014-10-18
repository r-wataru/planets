class Schedule
  def initialize(year, month)
    @month = month
    @year = year
    @now = Date.new(year.to_i,month.to_i,1)
  end

  def make_array
    array = []
    last_day = @now.end_of_month.strftime("%d").to_i
    array << Schedule.make_new_array(@now.strftime("%a"))
    days = ((array.first.last.to_i + 1)..last_day.to_i).map{|a| a}.in_groups_of(7)
    days.each do |d|
      array << d
    end
    return array
  end

  def self.make_new_array(week)
    array = nil
    case week
    when "Sun"
      array = [1,2,3,4,5,6,7]
    when "Mon"
      array = [nil,1,2,3,4,5,6]
    when "Tue"
      array = [nil,nil,1,2,3,4,5]
    when "Wed"
      array = [nil,nil,nil,1,2,3,4]
    when "Thu"
      array = [nil,nil,nil,nil,1,2,3]
    when "Fri"
      array = [nil,nil,nil,nil,nil,1,2]
    else
      array = [nil,nil,nil,nil,nil,nil,1]
    end
    return array
  end
end