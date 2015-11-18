require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'
include Clockwork

every(1.week,'weekly_worker called', :at => 'Thursday 10:00', :tz => 'UTC') { WeeklyWorker.perform_async }

# every(1.day,'weekly_worker called', :at => '09:50', :tz => 'UTC') { WeeklyWorker.perform_async }

# every(1.day,'monthly worker called', :at => '11:45', :tz => 'UTC') { MonthlyEmailWorker.perform_async }

every(1.day,'monthly worker called', :at => '14:00', :tz => 'UTC',:if => lambda { |t| ((1..7).to_a.include?(t.day) and t.wday==4)}) { MonthlyEmailWorker.perform_async }


# every(1.day, 'monthly worker called', :if => lambda { |t| t.day == 1 } ) { MonthlyEmailWorker.perform_async }

every(30.seconds,'bunching_worker called') { BunchingNotificationWorker.perform_async }




