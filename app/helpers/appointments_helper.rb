module AppointmentsHelper
    def range_hours
        range_hours = []
        range_date = DateTime.now.utc.change({hour: 9, minute: 0})
        (1..18).each do |num|
            range_hours << range_date
            range_date.strftime("%H:%M").to_s == "11:30" ? range_date = range_date + 90.minutes : range_date = range_date + 30.minutes
        end
        range_hours
    end
end
